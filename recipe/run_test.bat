@echo on
setlocal EnableDelayedExpansion

if not exist %LIBRARY_INC%\\cutensor.h exit 1
if not exist %LIBRARY_INC%\\cutensorMg.h exit 1
if not exist %LIBRARY_INC%\\cutensor\\types.h exit 1
if not exist %LIBRARY_BIN%\\cutensor.dll exit 1
if not exist %LIBRARY_BIN%\\cutensorMg.dll exit 1
if not exist %LIBRARY_LIB%\\cutensor.lib exit 1
if not exist %LIBRARY_LIB%\\cutensorMg.lib exit 1
