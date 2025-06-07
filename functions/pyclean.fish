function pyclean --description "Clean Python cache files from current directory"
    echo "🧹 Cleaning Python cache files..."
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -type f -name "*.py[co]" -delete
    echo "✅ Python cache cleaned."
end
