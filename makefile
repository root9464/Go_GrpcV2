# makefile for protogen
get-deps:
	go get -u google.golang.org/protobuf/cmd/protoc-gen-go
	go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway

generate:
	make generate-note-api

generete-proto:
	protoc -I ./proto \
	--go_out ./proto/out --go_opt paths=source_relative \
	--go-grpc_out ./proto/out --go-grpc_opt paths=source_relative \
	--grpc-gateway_out ./proto/out --grpc-gateway_opt paths=source_relative \
	./protoproto.proto

vendor-proto:
	@if [ ! -d vendor.protogen/google ]; then \
		git clone https://github.com/googleapis/googleapis vendor.protogen/googleapis &&\
		mkdir -p  vendor.protogen/google/ &&\
		mv vendor.protogen/googleapis/google/api vendor.protogen/google &&\
		rm -rf vendor.protogen/googleapis ;\
	fi