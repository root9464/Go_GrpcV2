package main

import (
	"context"
	"net/http"
	pb "root/proto/out"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()
	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithTransportCredentials(insecure.NewCredentials())}
	err := pb.RegisterHelloSeviceHandlerFromEndpoint(ctx, mux, "localhost:3001", opts)
	if err != nil {
		panic(err)
	}

	if err := http.ListenAndServe(":8081", mux); err != nil {
		panic(err)
	}
}
