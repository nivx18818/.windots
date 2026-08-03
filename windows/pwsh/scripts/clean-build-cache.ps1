$targets = @("node_modules", "dist", "build", "generated", ".cache", ".next", ".turbo")

foreach ($t in $targets) {
    Get-ChildItem -Recurse -Directory -Filter $t -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force
}
