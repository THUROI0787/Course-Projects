# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Services.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import builder as _builder
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


import Message2Clients_pb2 as Message2Clients__pb2
import Message2Server_pb2 as Message2Server__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x0eServices.proto\x12\x08protobuf\x1a\x15Message2Clients.proto\x1a\x14Message2Server.proto2\x80\x08\n\x10\x41vailableService\x12\x33\n\rTryConnection\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12=\n\tAddPlayer\x12\x13.protobuf.PlayerMsg\x1a\x19.protobuf.MessageToClient0\x01\x12,\n\x04Move\x12\x11.protobuf.MoveMsg\x1a\x11.protobuf.MoveRes\x12\x30\n\x08PickProp\x12\x11.protobuf.PropMsg\x1a\x11.protobuf.BoolRes\x12/\n\x07UseProp\x12\x11.protobuf.PropMsg\x1a\x11.protobuf.BoolRes\x12\x31\n\tThrowProp\x12\x11.protobuf.PropMsg\x1a\x11.protobuf.BoolRes\x12\x31\n\x08UseSkill\x12\x12.protobuf.SkillMsg\x1a\x11.protobuf.BoolRes\x12\x33\n\x0bSendMessage\x12\x11.protobuf.SendMsg\x1a\x11.protobuf.BoolRes\x12\x33\n\rStartLearning\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12\x41\n\x0fStartRescueMate\x12\x1b.protobuf.TreatAndRescueMsg\x1a\x11.protobuf.BoolRes\x12@\n\x0eStartTreatMate\x12\x1b.protobuf.TreatAndRescueMsg\x1a\x11.protobuf.BoolRes\x12\x30\n\x06\x41ttack\x12\x13.protobuf.AttackMsg\x1a\x11.protobuf.BoolRes\x12.\n\x08Graduate\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12.\n\x08OpenDoor\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12/\n\tCloseDoor\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12\x30\n\nSkipWindow\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12\x33\n\rStartOpenGate\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12\x34\n\x0eStartOpenChest\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolRes\x12\x32\n\x0c\x45ndAllAction\x12\x0f.protobuf.IDMsg\x1a\x11.protobuf.BoolResb\x06proto3')

_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, globals())
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'Services_pb2', globals())
if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _AVAILABLESERVICE._serialized_start=74
  _AVAILABLESERVICE._serialized_end=1098
# @@protoc_insertion_point(module_scope)
