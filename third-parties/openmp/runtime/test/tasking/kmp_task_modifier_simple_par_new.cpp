﻿// RUN: %libomp-cxx-compile-and-run

#include <stdio.h>
#include <omp.h>

#define NT 4
#define INIT 10

/*
The test emulates code generation needed for reduction with task modifier on
parallel construct.

Note: tasks could just use in_reduction clause, but compiler does not accept
this because of bug: it mistakenly requires reduction item to be shared, which
is only true for reduction on worksharing and wrong for task reductions.
*/

//------------------------------------------------
// OpenMP runtime library routines
#ifdef __cplusplus
extern "C" {
#endif
extern void *__kmpc_task_reduction_get_th_data(int gtid, void *tg, void *item);
// extern void* __kmpc_task_reduction_modifier_init(void *loc, int gtid, int
// is_ws, int num, void* data);
extern void *__kmpc_taskred_modifier_init(void *loc, int gtid, int is_ws,
                                          int num, void *data);
extern void __kmpc_task_reduction_modifier_fini(void *loc, int gtid, int is_ws);
extern int __kmpc_global_thread_num(void *);
#ifdef __cplusplus
}
#endif

//------------------------------------------------
// Compiler-generated code

typedef struct red_input {
  void *reduce_shar; /**< shared between tasks item to reduce into */
  void *reduce_orig; /**< original reduction item used for initialization */
  size_t reduce_size; /**< size of data item in bytes */
  // three compiler-generated routines (init, fini are optional):
  void *reduce_init; /**< data initialization routine (single parameter) */
  void *reduce_fini; /**< data finalization routine */
  void *reduce_comb; /**< data combiner routine */
  unsigned flags; /**< flags for additional info from compiler */
} red_input_t;

void i_comb(void *lhs, void *rhs) { *(int *)lhs += *(int *)rhs; }

int main() {
  int var = INIT;
  int *p_var_orig = &var;
  omp_set_dynamic(0);
  omp_set_num_threads(NT);
//  #pragma omp parallel reduction(task,+:var)
#pragma omp parallel reduction(+ : var) shared(p_var_orig)
  {
    int gtid = __kmpc_global_thread_num(NULL);
    void *tg; // pointer to taskgroup (optional)
    red_input_t r_var;
    r_var.reduce_shar = &var;
    r_var.reduce_orig =
        p_var_orig; // not used in this test but illustrates codegen
    r_var.reduce_size = sizeof(var);
    r_var.reduce_init = NULL;
    r_var.reduce_fini = NULL;
    r_var.reduce_comb = (void *)&i_comb;
    tg = __kmpc_taskred_modifier_init(
        NULL, // ident_t loc;
        gtid,
        0, // 1 - worksharing construct, 0 - parallel
        1, // number of reduction objects
        &r_var // related data
        );
    var++;
#pragma omp task /*in_reduction(+:var)*/ shared(var)
    {
      int gtid = __kmpc_global_thread_num(NULL);
      int *p_var = (int *)__kmpc_task_reduction_get_th_data(gtid, tg, &var);
      *p_var += 1;
    }
    if (omp_get_thread_num() > 0) {
#pragma omp task /*in_reduction(+:var)*/ shared(var)
      {
        int gtid = __kmpc_global_thread_num(NULL);
        int *p_var = (int *)__kmpc_task_reduction_get_th_data(gtid, tg, &var);
        *p_var += 1;
      }
    }
    __kmpc_task_reduction_modifier_fini(NULL, gtid, 0);
  }
  if (var == INIT + NT * 3 - 1) {
    printf("passed\n");
    return 0;
  } else {
    printf("failed: var = %d (!= %d)\n", var, INIT + NT * 3 - 1);
    return 1;
  }
}
