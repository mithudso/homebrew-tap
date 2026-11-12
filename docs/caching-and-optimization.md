# Caching and optimization

Homebrew owns download caching and validates archive hashes. The tap has no
application cache, database queries, event loop or hot request path to optimize.
The index checker scans its small JSON path list once and performs local file
checks. Keep formula definitions direct; do not introduce a package abstraction
or shared runtime until real duplicated behavior warrants it.
