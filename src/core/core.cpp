// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "core.hpp"

#include <grpc++/security/server_credentials.h>
#include <grpc++/server.h>
#include <grpc++/server_builder.h>

#include "HealthCheckServiceImpl.hpp"

namespace core {

void run()
{
    try {
        const std::string serverAddress{ "0.0.0.0:9000" };

        HealthCheckServiceImpl healthCheckService{};

        grpc::ServerBuilder builder;
        builder.AddListeningPort(serverAddress, grpc::InsecureServerCredentials());
        builder.RegisterService(&healthCheckService);

        std::unique_ptr<grpc::Server> server{ builder.BuildAndStart() };
        std::cout << "Server listening on " << serverAddress << std::endl;

        server->Wait();
    }
    catch (const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
}

} // namespace core
