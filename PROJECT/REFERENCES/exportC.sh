${BASE_PROJECT}/${LOCAL_PROJECT}/MAKEFILEGENERATION/export.sh $1

cd ${PROJECT_HOME}/$1

cd ${EXPORT_LIBRARY}
ctags --fields=+l --c-kinds=+p --c++-kinds=+p --extra=+q -R
