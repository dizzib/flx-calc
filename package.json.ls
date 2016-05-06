name       : \flx-calc
version    : \0.1.0
homepage   : \https://github.com/dizzib/flx-calc
bugs       : \https://github.com/dizzib/flx-calc/issues
license:   : \MIT
author     : \dizzib
private    : true
repository :
  type: \git
  url : \https://github.com/dizzib/flx-calc
scripts:
  start: './task/bootstrap && node ./_build/task/repl'
devDependencies:
  chalk        : \~0.4.0
  chokidar     : \~1.0.1
  growly       : \~1.2.0
  jade         : \~1.6.0
  livescript   : \~1.4.0
  lodash       : \~2.4.1
  marked       : \~0.3.1
  nib          : \~0.9.0
  'node-static': \~0.7.7
  shelljs      : \~0.2.6
  stylus       : \~0.31.0
  'wait.for'   : \~0.6.3
engines:
  npm : '>=1.0.x'
