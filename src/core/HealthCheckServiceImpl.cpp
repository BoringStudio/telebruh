// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "HealthCheckServiceImpl.hpp"

using namespace grpc;

namespace core {

Status HealthCheckServiceImpl::CheckHealth(ServerContext* context,
                                           const HealthCheckRequest* request,
                                           HealthCheckReply* response)
{
    response->set_version_major(0);
    response->set_version_minor(0);
    response->set_version_patch(1);

    return Status::OK;
}

} // namespace core
