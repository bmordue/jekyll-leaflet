set -ex
PREVIOUS_VERSION=0.0.2
NEXT_VERSION=0.0.3
GEMSPEC=jekyll-leaflet.gemspec
git commit -am "changes for version $NEXT_VERSION"
sed -i~ "s/$PREVIOUS_VERSION/$NEXT_VERSION/g" $GEMSPEC
git add $GEMSPEC && git commit -m "version $NEXT_VERSION"
docker run --rm -v $(pwd):/wrk -w /wrk ruby:2.6 gem build $GEMSPEC
git tag "v$NEXT_VERSION"
docker run --rm -v $(pwd):/wrk -w /wrk -v $HOME/.gem/credentials:/.gem/credentials ruby:2.6 gem push jekyll-leaflet-$NEXT_VERSION.gem --config-file /.gem/credentials
rm $GEMSPEC~
