namespace :protobuf do
  desc "Compile the .proto files into Ruby stub classes"
  task :compile do
    sh 'protoc --ruby_out=lib/blick -I proto ./proto/*.proto'
  end
end
