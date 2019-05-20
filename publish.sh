PREVIOUS_VERSION=0.0.1
NEXT_VERSION=0.0.2
sed -i~ 's/$PREVIOUS_VERSION/$NEXT_VERSION/g' jekyll-leaflet.gemspec
git add jekyll-leaflet.gemspec && git commit -m 'version $NEXT_VERSION'
docker run --rm -v $(pwd):/wrk -w /wrk ruby:2.6 gem build jekyll-leaflet.gemspec
git tag "v$NEXT_VERSION"
docker run --rm -v $(pwd):/wrk -w /wrk -v $HOME/.gem/credentials:/.gem/credentials ruby:2.6 gem push jekyll-leaflet-$NEXT_VERSION.gem --config-file /.gem/credentials
