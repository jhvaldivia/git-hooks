pushd .git/hooks
ln -s ../../hooks/pre-commit.sh pre-commit
chmod u+x pre-commit
popd
