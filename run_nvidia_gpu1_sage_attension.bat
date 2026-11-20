@echo off
cd /d %~dp0

set CUDA_VISIBLE_DEVICES=1

echo Activating virtual environment...
:: 仮想環境の有効化
call .venv\Scripts\activate

if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to activate virtual environment.
    pause
    exit /b
)

echo Running main.py...
:: Pythonスクリプトの実行
@REM python main.py
python -s main.py --port 8191 --use-sage-attention --output-directory V:\ai\outputs\comfy --enable-cors-header --enable-manager

echo.
echo Process finished.
pause