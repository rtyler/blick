namespace :protobuf do
  task :compile do
    sh 'protoc --ruby_out=lib/blick -I proto ./proto/*.proto'
  end
end
