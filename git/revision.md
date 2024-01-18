## git revision
```bash
v$(printf "%03d" $(git rev-list --count --all))-$(git rev-parse --short HEAD)
```
v059-4a1dfcd
