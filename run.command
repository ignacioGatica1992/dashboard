#!/bin/bash
# Double-click this file in Finder to launch the app on macOS.

# Move to the folder containing this script regardless of where it was launched from
cd "$(dirname "$0")"

VENV_DIR=".venv"

echo "================================================"
echo "   Doc → Markdown Converter"
echo "================================================"
echo ""

# ── 1. Verify Python 3 is available ─────────────────────────────────────────
if ! command -v python3 &>/dev/null; then
    echo "❌  Python 3 not found."
    echo ""
    echo "Install it via Homebrew:"
    echo "  1. Open Terminal and run:"
    echo "     /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "  2. Then: brew install python"
    echo ""
    read -rp "Press Enter to close..."
    exit 1
fi

PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "✅  Python $PYTHON_VERSION detected"

# ── 2. Create virtual environment if it doesn't exist ───────────────────────
if [ ! -d "$VENV_DIR" ]; then
    echo "📦  Creating virtual environment (first run only)..."
    python3 -m venv "$VENV_DIR"
fi

# ── 3. Activate virtual environment ─────────────────────────────────────────
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

# ── 4. Install / update dependencies ────────────────────────────────────────
echo "📥  Installing dependencies..."
pip install -q --upgrade pip
pip install -q -r requirements.txt

# ── 5. Launch the Streamlit app ──────────────────────────────────────────────
echo ""
echo "🚀  Starting app — your browser will open automatically."
echo "    Press Ctrl+C here to stop the server."
echo ""
streamlit run streamlit_app.py
