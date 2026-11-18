@echo on
setlocal EnableDelayedExpansion

if not exist %LIBRARY_INC%\\cutensor.h exit 1
if not exist %LIBRARY_INC%\\cutensorMg.h exit 1
if not exist %LIBRARY_INC%\\cutensor\\types.h exit 1
if not exist %LIBRARY_BIN%\\cutensor.dll exit 1
if not exist %LIBRARY_BIN%\\cutensorMg.dll exit 1
if not exist %LIBRARY_LIB%\\cutensor.lib exit 1
if not exist %LIBRARY_LIB%\\cutensorMg.lib exit 1

:: Anaconda: build samples to verify the installed headers/libs (no cuTENSORMp on Windows)
ver > nul
cd sample_linux\cuTENSOR
if errorlevel 1 exit 1
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensor contraction.cu -o contraction
if errorlevel 1 exit 1
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensor reduction.cu -o reduction
if errorlevel 1 exit 1
ver > nul
cd ..\cuTENSORMg
if errorlevel 1 exit 1
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcutensorMg -lcutensor contraction_multi_gpu.cu -o contraction_multi_gpu
if errorlevel 1 exit 1
