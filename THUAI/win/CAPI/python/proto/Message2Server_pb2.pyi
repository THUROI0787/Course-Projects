import MessageType_pb2 as _MessageType_pb2
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class AttackMsg(_message.Message):
    __slots__ = ["angle", "player_id"]
    ANGLE_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    angle: float
    player_id: int
    def __init__(self, player_id: _Optional[int] = ..., angle: _Optional[float] = ...) -> None: ...

class IDMsg(_message.Message):
    __slots__ = ["player_id"]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    player_id: int
    def __init__(self, player_id: _Optional[int] = ...) -> None: ...

class MoveMsg(_message.Message):
    __slots__ = ["angle", "player_id", "time_in_milliseconds"]
    ANGLE_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    TIME_IN_MILLISECONDS_FIELD_NUMBER: _ClassVar[int]
    angle: float
    player_id: int
    time_in_milliseconds: int
    def __init__(self, player_id: _Optional[int] = ..., angle: _Optional[float] = ..., time_in_milliseconds: _Optional[int] = ...) -> None: ...

class PlayerMsg(_message.Message):
    __slots__ = ["player_id", "player_type", "student_type", "tricker_type"]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    PLAYER_TYPE_FIELD_NUMBER: _ClassVar[int]
    STUDENT_TYPE_FIELD_NUMBER: _ClassVar[int]
    TRICKER_TYPE_FIELD_NUMBER: _ClassVar[int]
    player_id: int
    player_type: _MessageType_pb2.PlayerType
    student_type: _MessageType_pb2.StudentType
    tricker_type: _MessageType_pb2.TrickerType
    def __init__(self, player_id: _Optional[int] = ..., student_type: _Optional[_Union[_MessageType_pb2.StudentType, str]] = ..., tricker_type: _Optional[_Union[_MessageType_pb2.TrickerType, str]] = ..., player_type: _Optional[_Union[_MessageType_pb2.PlayerType, str]] = ...) -> None: ...

class PropMsg(_message.Message):
    __slots__ = ["player_id", "prop_type"]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    PROP_TYPE_FIELD_NUMBER: _ClassVar[int]
    player_id: int
    prop_type: _MessageType_pb2.PropType
    def __init__(self, player_id: _Optional[int] = ..., prop_type: _Optional[_Union[_MessageType_pb2.PropType, str]] = ...) -> None: ...

class SendMsg(_message.Message):
    __slots__ = ["binary_message", "player_id", "text_message", "to_player_id"]
    BINARY_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    TEXT_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    TO_PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    binary_message: bytes
    player_id: int
    text_message: str
    to_player_id: int
    def __init__(self, player_id: _Optional[int] = ..., to_player_id: _Optional[int] = ..., text_message: _Optional[str] = ..., binary_message: _Optional[bytes] = ...) -> None: ...

class SkillMsg(_message.Message):
    __slots__ = ["player_id", "skill_id"]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    SKILL_ID_FIELD_NUMBER: _ClassVar[int]
    player_id: int
    skill_id: int
    def __init__(self, player_id: _Optional[int] = ..., skill_id: _Optional[int] = ...) -> None: ...

class TreatAndRescueMsg(_message.Message):
    __slots__ = ["player_id", "to_player_id"]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    TO_PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    player_id: int
    to_player_id: int
    def __init__(self, player_id: _Optional[int] = ..., to_player_id: _Optional[int] = ...) -> None: ...
