﻿#pragma once
#include <fast_io.h>
#include <fast_io_device.h>

namespace uwvm::path
{
    inline ::fast_io::dir_file working_path_df{::fast_io::at_fdcwd(), u8"."};

}  // namespace uwvm::path
