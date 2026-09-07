@echo off
echo ========================================
echo   Building Flutter web app...
echo ========================================
flutter build web --base-href /uiflutter_portfolio/
if %errorlevel% neq 0 (
    echo.
    echo BUILD FAILED. Fix the errors above before deploying.
    pause
    exit /b
)
echo.
echo ========================================
echo   Clearing old docs folder...
echo ========================================
rmdir /s /q docs
mkdir docs
echo.
echo ========================================
echo   Copying new build into docs...
echo ========================================
xcopy /e /i /y build\web docs
type nul > docs\.nojekyll
echo.
echo ========================================
echo   Pushing to GitHub...
echo ========================================
git add .
git commit -m "update site content"
git push origin main
echo.
echo ========================================
echo   Done! Check your live site in 1-2 minutes:
echo   https://darshitha-18.github.io/uiflutter_portfolio/
echo ========================================
pause
