@echo on

if not exist %PREFIX% mkdir %PREFIX%
if errorlevel 1 exit 1
if not exist %LIBRARY_PREFIX% mkdir %LIBRARY_PREFIX%
if errorlevel 1 exit 1
if not exist %LIBRARY_BIN% mkdir %LIBRARY_BIN%
if errorlevel 1 exit 1
if not exist %LIBRARY_LIB% mkdir %LIBRARY_LIB%
if errorlevel 1 exit 1
if not exist %LIBRARY_INC% mkdir %LIBRARY_INC%
if errorlevel 1 exit 1

copy include\cutensor.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy include\cutensorMg.h %LIBRARY_INC%\
if errorlevel 1 exit 1
mkdir %LIBRARY_INC%\cutensor
if errorlevel 1 exit 1
copy include\cutensor\types.h %LIBRARY_INC%\cutensor\
if errorlevel 1 exit 1
copy bin\*.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1
copy lib\*.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1

:: Build samples to verify the installation
cd %SRC_DIR%\sample_linux\cuTENSOR
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensor contraction.cu -o contraction
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensor reduction.cu -o reduction
cd %SRC_DIR%\sample_linux\cuTENSORMg
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensorMg -lcutensor contraction_multi_gpu.cu -o contraction_multi_gpu
