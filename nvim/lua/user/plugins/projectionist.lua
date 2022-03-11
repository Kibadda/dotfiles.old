vim.cmd([[
let g:projectionist_heuristics = {
    \ "artisan": {
    \   "*": {
    \     "console": "php artisan tinker",
    \   },
    \   "app/Http/Controllers/*Controller.php": {
    \     "type": "source",
    \     "alternate": "tests/Feature/{}Test.php",
    \   },
    \   "tests/Feature/*Test.php": {
    \     "type": "test",
    \     "alternate": "app/Http/Controllers/{}Controller.php",
    \   },
    \   "app/Http/Resources/*Resource.php" : {
    \     "type": "source",
    \     "alternate": "tests/Unit/Resource/{}Test.php"
    \   },
    \   "tests/Unit/Resource/*Test.php": {
    \     "type": "test",
    \     "alternate": "app/Http/Resources/{}Resource.php",
    \   },
    \   "app/Http/Requests/*Request.php" : {
    \     "type": "source",
    \     "alternate": "tests/Unit/Requests/{}Test.php"
    \   },
    \   "tests/Unit/Requests/*Test.php": {
    \     "type": "test",
    \     "alternate": "app/Http/Requests/{}Request.php",
    \   },
    \   "app/Notifications/*Notification.php" : {
    \     "type": "source",
    \     "alternate": "tests/Unit/Notifications/{}Test.php"
    \   },
    \   "tests/Unit/Notifications/*Test.php": {
    \     "type": "test",
    \     "alternate": "app/Notifications/{}Notification.php",
    \   },
    \ },
    \ "deploy": {
    \   "project/lib/objects/*.class.php": {
    \     "type": "source",
    \     "alternate": "project/lib/dao/{}DAO.class.php",
    \   },
    \   "project/lib/dao/*DAO.class.php": {
    \     "type": "test",
    \     "alternate": "project/lib/objects/{}.class.php",
    \   },
    \   "project/htdocs/*.php": {
    \     "type": "source",
    \     "alternate": "project/templates/{}.tpl",
    \   },
    \   "project/templates/*.tpl": {
    \     "type": "test",
    \     "alternate": "project/htdocs/{}.php",
    \   },
    \ }}
]])
