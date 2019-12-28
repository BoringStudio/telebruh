#pragma once

#include "generated/health_check_service.grpc.pb.h"
#include "generated/health_check_service.pb.h"

namespace core {

class HealthCheckServiceImpl final : public HealthCheckService::Service {
public:
    ::grpc::Status CheckHealth(::grpc::ServerContext* context,
                               const HealthCheckRequest* request,
                               HealthCheckReply* response) override;

private:
};

} // namespace core
