# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import Message2Clients_pb2 as Message2Clients__pb2
import Message2Server_pb2 as Message2Server__pb2


class AvailableServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.TryConnection = channel.unary_unary(
                '/protobuf.AvailableService/TryConnection',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.AddPlayer = channel.unary_stream(
                '/protobuf.AvailableService/AddPlayer',
                request_serializer=Message2Server__pb2.PlayerMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.MessageToClient.FromString,
                )
        self.Move = channel.unary_unary(
                '/protobuf.AvailableService/Move',
                request_serializer=Message2Server__pb2.MoveMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.MoveRes.FromString,
                )
        self.PickProp = channel.unary_unary(
                '/protobuf.AvailableService/PickProp',
                request_serializer=Message2Server__pb2.PropMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.UseProp = channel.unary_unary(
                '/protobuf.AvailableService/UseProp',
                request_serializer=Message2Server__pb2.PropMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.ThrowProp = channel.unary_unary(
                '/protobuf.AvailableService/ThrowProp',
                request_serializer=Message2Server__pb2.PropMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.UseSkill = channel.unary_unary(
                '/protobuf.AvailableService/UseSkill',
                request_serializer=Message2Server__pb2.SkillMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.SendMessage = channel.unary_unary(
                '/protobuf.AvailableService/SendMessage',
                request_serializer=Message2Server__pb2.SendMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.StartLearning = channel.unary_unary(
                '/protobuf.AvailableService/StartLearning',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.StartRescueMate = channel.unary_unary(
                '/protobuf.AvailableService/StartRescueMate',
                request_serializer=Message2Server__pb2.TreatAndRescueMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.StartTreatMate = channel.unary_unary(
                '/protobuf.AvailableService/StartTreatMate',
                request_serializer=Message2Server__pb2.TreatAndRescueMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.Attack = channel.unary_unary(
                '/protobuf.AvailableService/Attack',
                request_serializer=Message2Server__pb2.AttackMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.Graduate = channel.unary_unary(
                '/protobuf.AvailableService/Graduate',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.OpenDoor = channel.unary_unary(
                '/protobuf.AvailableService/OpenDoor',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.CloseDoor = channel.unary_unary(
                '/protobuf.AvailableService/CloseDoor',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.SkipWindow = channel.unary_unary(
                '/protobuf.AvailableService/SkipWindow',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.StartOpenGate = channel.unary_unary(
                '/protobuf.AvailableService/StartOpenGate',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.StartOpenChest = channel.unary_unary(
                '/protobuf.AvailableService/StartOpenChest',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )
        self.EndAllAction = channel.unary_unary(
                '/protobuf.AvailableService/EndAllAction',
                request_serializer=Message2Server__pb2.IDMsg.SerializeToString,
                response_deserializer=Message2Clients__pb2.BoolRes.FromString,
                )


class AvailableServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def TryConnection(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def AddPlayer(self, request, context):
        """游戏开局调用一次的服务
        连接上后等待游戏开始，server会定时通过该服务向所有client发送消息。
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Move(self, request, context):
        """游戏过程中玩家执行操作的服务
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def PickProp(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UseProp(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ThrowProp(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UseSkill(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def SendMessage(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def StartLearning(self, request, context):
        """rpc GetMessage (IDMsg) returns (stream MsgRes);
        开始修理机器
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def StartRescueMate(self, request, context):
        """开始救人
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def StartTreatMate(self, request, context):
        """开始治疗
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Attack(self, request, context):
        """攻击
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Graduate(self, request, context):
        """相当于逃跑
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def OpenDoor(self, request, context):
        """开门
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def CloseDoor(self, request, context):
        """关门
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def SkipWindow(self, request, context):
        """窗户
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def StartOpenGate(self, request, context):
        """开闸门
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def StartOpenChest(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def EndAllAction(self, request, context):
        """结束所有动作
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_AvailableServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'TryConnection': grpc.unary_unary_rpc_method_handler(
                    servicer.TryConnection,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'AddPlayer': grpc.unary_stream_rpc_method_handler(
                    servicer.AddPlayer,
                    request_deserializer=Message2Server__pb2.PlayerMsg.FromString,
                    response_serializer=Message2Clients__pb2.MessageToClient.SerializeToString,
            ),
            'Move': grpc.unary_unary_rpc_method_handler(
                    servicer.Move,
                    request_deserializer=Message2Server__pb2.MoveMsg.FromString,
                    response_serializer=Message2Clients__pb2.MoveRes.SerializeToString,
            ),
            'PickProp': grpc.unary_unary_rpc_method_handler(
                    servicer.PickProp,
                    request_deserializer=Message2Server__pb2.PropMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'UseProp': grpc.unary_unary_rpc_method_handler(
                    servicer.UseProp,
                    request_deserializer=Message2Server__pb2.PropMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'ThrowProp': grpc.unary_unary_rpc_method_handler(
                    servicer.ThrowProp,
                    request_deserializer=Message2Server__pb2.PropMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'UseSkill': grpc.unary_unary_rpc_method_handler(
                    servicer.UseSkill,
                    request_deserializer=Message2Server__pb2.SkillMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'SendMessage': grpc.unary_unary_rpc_method_handler(
                    servicer.SendMessage,
                    request_deserializer=Message2Server__pb2.SendMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'StartLearning': grpc.unary_unary_rpc_method_handler(
                    servicer.StartLearning,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'StartRescueMate': grpc.unary_unary_rpc_method_handler(
                    servicer.StartRescueMate,
                    request_deserializer=Message2Server__pb2.TreatAndRescueMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'StartTreatMate': grpc.unary_unary_rpc_method_handler(
                    servicer.StartTreatMate,
                    request_deserializer=Message2Server__pb2.TreatAndRescueMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'Attack': grpc.unary_unary_rpc_method_handler(
                    servicer.Attack,
                    request_deserializer=Message2Server__pb2.AttackMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'Graduate': grpc.unary_unary_rpc_method_handler(
                    servicer.Graduate,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'OpenDoor': grpc.unary_unary_rpc_method_handler(
                    servicer.OpenDoor,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'CloseDoor': grpc.unary_unary_rpc_method_handler(
                    servicer.CloseDoor,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'SkipWindow': grpc.unary_unary_rpc_method_handler(
                    servicer.SkipWindow,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'StartOpenGate': grpc.unary_unary_rpc_method_handler(
                    servicer.StartOpenGate,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'StartOpenChest': grpc.unary_unary_rpc_method_handler(
                    servicer.StartOpenChest,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
            'EndAllAction': grpc.unary_unary_rpc_method_handler(
                    servicer.EndAllAction,
                    request_deserializer=Message2Server__pb2.IDMsg.FromString,
                    response_serializer=Message2Clients__pb2.BoolRes.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'protobuf.AvailableService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class AvailableService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def TryConnection(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/TryConnection',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def AddPlayer(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_stream(request, target, '/protobuf.AvailableService/AddPlayer',
            Message2Server__pb2.PlayerMsg.SerializeToString,
            Message2Clients__pb2.MessageToClient.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Move(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/Move',
            Message2Server__pb2.MoveMsg.SerializeToString,
            Message2Clients__pb2.MoveRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def PickProp(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/PickProp',
            Message2Server__pb2.PropMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def UseProp(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/UseProp',
            Message2Server__pb2.PropMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def ThrowProp(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/ThrowProp',
            Message2Server__pb2.PropMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def UseSkill(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/UseSkill',
            Message2Server__pb2.SkillMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def SendMessage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/SendMessage',
            Message2Server__pb2.SendMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def StartLearning(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/StartLearning',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def StartRescueMate(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/StartRescueMate',
            Message2Server__pb2.TreatAndRescueMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def StartTreatMate(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/StartTreatMate',
            Message2Server__pb2.TreatAndRescueMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Attack(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/Attack',
            Message2Server__pb2.AttackMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Graduate(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/Graduate',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def OpenDoor(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/OpenDoor',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def CloseDoor(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/CloseDoor',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def SkipWindow(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/SkipWindow',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def StartOpenGate(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/StartOpenGate',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def StartOpenChest(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/StartOpenChest',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def EndAllAction(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/protobuf.AvailableService/EndAllAction',
            Message2Server__pb2.IDMsg.SerializeToString,
            Message2Clients__pb2.BoolRes.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
