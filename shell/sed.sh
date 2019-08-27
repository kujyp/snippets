
# sed for MacOS
sed -i '' "s/^__version__.*/__version__ = '0.0.0'/" mtrobust/about.py
# sed for Linux
sed -i "s/^__version__.*/__version__ = '0.0.0'/" mtrobust/about.py
cat mtrobust/about.py
