import MessageType_pb2 as _MessageType_pb2
from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Iterable as _Iterable, Mapping as _Mapping, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class BoolRes(_message.Message):
    __slots__ = ["act_success"]
    ACT_SUCCESS_FIELD_NUMBER: _ClassVar[int]
    act_success: bool
    def __init__(self, act_success: bool = ...) -> None: ...

class MessageOfAll(_message.Message):
    __slots__ = ["game_time", "student_graduated", "student_quited", "student_score", "subject_finished", "tricker_score"]
    GAME_TIME_FIELD_NUMBER: _ClassVar[int]
    STUDENT_GRADUATED_FIELD_NUMBER: _ClassVar[int]
    STUDENT_QUITED_FIELD_NUMBER: _ClassVar[int]
    STUDENT_SCORE_FIELD_NUMBER: _ClassVar[int]
    SUBJECT_FINISHED_FIELD_NUMBER: _ClassVar[int]
    TRICKER_SCORE_FIELD_NUMBER: _ClassVar[int]
    game_time: int
    student_graduated: int
    student_quited: int
    student_score: int
    subject_finished: int
    tricker_score: int
    def __init__(self, game_time: _Optional[int] = ..., subject_finished: _Optional[int] = ..., student_graduated: _Optional[int] = ..., student_quited: _Optional[int] = ..., student_score: _Optional[int] = ..., tricker_score: _Optional[int] = ...) -> None: ...

class MessageOfBombedBullet(_message.Message):
    __slots__ = ["bomb_range", "facing_direction", "mapping_id", "type", "x", "y"]
    BOMB_RANGE_FIELD_NUMBER: _ClassVar[int]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    MAPPING_ID_FIELD_NUMBER: _ClassVar[int]
    TYPE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    bomb_range: float
    facing_direction: float
    mapping_id: int
    type: _MessageType_pb2.BulletType
    x: int
    y: int
    def __init__(self, type: _Optional[_Union[_MessageType_pb2.BulletType, str]] = ..., x: _Optional[int] = ..., y: _Optional[int] = ..., facing_direction: _Optional[float] = ..., mapping_id: _Optional[int] = ..., bomb_range: _Optional[float] = ...) -> None: ...

class MessageOfBullet(_message.Message):
    __slots__ = ["bomb_range", "facing_direction", "guid", "speed", "team", "type", "x", "y"]
    BOMB_RANGE_FIELD_NUMBER: _ClassVar[int]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    GUID_FIELD_NUMBER: _ClassVar[int]
    SPEED_FIELD_NUMBER: _ClassVar[int]
    TEAM_FIELD_NUMBER: _ClassVar[int]
    TYPE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    bomb_range: float
    facing_direction: float
    guid: int
    speed: int
    team: _MessageType_pb2.PlayerType
    type: _MessageType_pb2.BulletType
    x: int
    y: int
    def __init__(self, type: _Optional[_Union[_MessageType_pb2.BulletType, str]] = ..., x: _Optional[int] = ..., y: _Optional[int] = ..., facing_direction: _Optional[float] = ..., guid: _Optional[int] = ..., team: _Optional[_Union[_MessageType_pb2.PlayerType, str]] = ..., bomb_range: _Optional[float] = ..., speed: _Optional[int] = ...) -> None: ...

class MessageOfChest(_message.Message):
    __slots__ = ["progress", "x", "y"]
    PROGRESS_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    progress: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., progress: _Optional[int] = ...) -> None: ...

class MessageOfClassroom(_message.Message):
    __slots__ = ["progress", "x", "y"]
    PROGRESS_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    progress: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., progress: _Optional[int] = ...) -> None: ...

class MessageOfDoor(_message.Message):
    __slots__ = ["is_open", "progress", "x", "y"]
    IS_OPEN_FIELD_NUMBER: _ClassVar[int]
    PROGRESS_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    is_open: bool
    progress: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., is_open: bool = ..., progress: _Optional[int] = ...) -> None: ...

class MessageOfGate(_message.Message):
    __slots__ = ["progress", "x", "y"]
    PROGRESS_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    progress: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., progress: _Optional[int] = ...) -> None: ...

class MessageOfHiddenGate(_message.Message):
    __slots__ = ["opened", "x", "y"]
    OPENED_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    opened: bool
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., opened: bool = ...) -> None: ...

class MessageOfMap(_message.Message):
    __slots__ = ["row"]
    class Row(_message.Message):
        __slots__ = ["col"]
        COL_FIELD_NUMBER: _ClassVar[int]
        col: _containers.RepeatedScalarFieldContainer[_MessageType_pb2.PlaceType]
        def __init__(self, col: _Optional[_Iterable[_Union[_MessageType_pb2.PlaceType, str]]] = ...) -> None: ...
    ROW_FIELD_NUMBER: _ClassVar[int]
    row: _containers.RepeatedCompositeFieldContainer[MessageOfMap.Row]
    def __init__(self, row: _Optional[_Iterable[_Union[MessageOfMap.Row, _Mapping]]] = ...) -> None: ...

class MessageOfNews(_message.Message):
    __slots__ = ["binary_message", "from_id", "text_message", "to_id"]
    BINARY_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    FROM_ID_FIELD_NUMBER: _ClassVar[int]
    TEXT_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    TO_ID_FIELD_NUMBER: _ClassVar[int]
    binary_message: bytes
    from_id: int
    text_message: str
    to_id: int
    def __init__(self, text_message: _Optional[str] = ..., binary_message: _Optional[bytes] = ..., from_id: _Optional[int] = ..., to_id: _Optional[int] = ...) -> None: ...

class MessageOfObj(_message.Message):
    __slots__ = ["bombed_bullet_message", "bullet_message", "chest_message", "classroom_message", "door_message", "gate_message", "hidden_gate_message", "map_message", "news_message", "prop_message", "student_message", "tricker_message"]
    BOMBED_BULLET_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    BULLET_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    CHEST_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    CLASSROOM_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    DOOR_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    GATE_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    HIDDEN_GATE_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    MAP_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    NEWS_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    PROP_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    STUDENT_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    TRICKER_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    bombed_bullet_message: MessageOfBombedBullet
    bullet_message: MessageOfBullet
    chest_message: MessageOfChest
    classroom_message: MessageOfClassroom
    door_message: MessageOfDoor
    gate_message: MessageOfGate
    hidden_gate_message: MessageOfHiddenGate
    map_message: MessageOfMap
    news_message: MessageOfNews
    prop_message: MessageOfProp
    student_message: MessageOfStudent
    tricker_message: MessageOfTricker
    def __init__(self, student_message: _Optional[_Union[MessageOfStudent, _Mapping]] = ..., tricker_message: _Optional[_Union[MessageOfTricker, _Mapping]] = ..., prop_message: _Optional[_Union[MessageOfProp, _Mapping]] = ..., bullet_message: _Optional[_Union[MessageOfBullet, _Mapping]] = ..., bombed_bullet_message: _Optional[_Union[MessageOfBombedBullet, _Mapping]] = ..., classroom_message: _Optional[_Union[MessageOfClassroom, _Mapping]] = ..., door_message: _Optional[_Union[MessageOfDoor, _Mapping]] = ..., gate_message: _Optional[_Union[MessageOfGate, _Mapping]] = ..., chest_message: _Optional[_Union[MessageOfChest, _Mapping]] = ..., hidden_gate_message: _Optional[_Union[MessageOfHiddenGate, _Mapping]] = ..., news_message: _Optional[_Union[MessageOfNews, _Mapping]] = ..., map_message: _Optional[_Union[MessageOfMap, _Mapping]] = ...) -> None: ...

class MessageOfPickedProp(_message.Message):
    __slots__ = ["facing_direction", "mapping_id", "type", "x", "y"]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    MAPPING_ID_FIELD_NUMBER: _ClassVar[int]
    TYPE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    facing_direction: float
    mapping_id: int
    type: _MessageType_pb2.PropType
    x: int
    y: int
    def __init__(self, type: _Optional[_Union[_MessageType_pb2.PropType, str]] = ..., x: _Optional[int] = ..., y: _Optional[int] = ..., facing_direction: _Optional[float] = ..., mapping_id: _Optional[int] = ...) -> None: ...

class MessageOfProp(_message.Message):
    __slots__ = ["facing_direction", "guid", "type", "x", "y"]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    GUID_FIELD_NUMBER: _ClassVar[int]
    TYPE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    facing_direction: float
    guid: int
    type: _MessageType_pb2.PropType
    x: int
    y: int
    def __init__(self, type: _Optional[_Union[_MessageType_pb2.PropType, str]] = ..., x: _Optional[int] = ..., y: _Optional[int] = ..., facing_direction: _Optional[float] = ..., guid: _Optional[int] = ...) -> None: ...

class MessageOfStudent(_message.Message):
    __slots__ = ["addiction", "buff", "bullet_type", "danger_alert", "determination", "facing_direction", "guid", "learning_speed", "player_id", "player_state", "prop", "radius", "rescue_progress", "score", "speed", "student_type", "time_until_skill_available", "treat_progress", "treat_speed", "view_range", "x", "y"]
    ADDICTION_FIELD_NUMBER: _ClassVar[int]
    BUFF_FIELD_NUMBER: _ClassVar[int]
    BULLET_TYPE_FIELD_NUMBER: _ClassVar[int]
    DANGER_ALERT_FIELD_NUMBER: _ClassVar[int]
    DETERMINATION_FIELD_NUMBER: _ClassVar[int]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    GUID_FIELD_NUMBER: _ClassVar[int]
    LEARNING_SPEED_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    PLAYER_STATE_FIELD_NUMBER: _ClassVar[int]
    PROP_FIELD_NUMBER: _ClassVar[int]
    RADIUS_FIELD_NUMBER: _ClassVar[int]
    RESCUE_PROGRESS_FIELD_NUMBER: _ClassVar[int]
    SCORE_FIELD_NUMBER: _ClassVar[int]
    SPEED_FIELD_NUMBER: _ClassVar[int]
    STUDENT_TYPE_FIELD_NUMBER: _ClassVar[int]
    TIME_UNTIL_SKILL_AVAILABLE_FIELD_NUMBER: _ClassVar[int]
    TREAT_PROGRESS_FIELD_NUMBER: _ClassVar[int]
    TREAT_SPEED_FIELD_NUMBER: _ClassVar[int]
    VIEW_RANGE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    addiction: int
    buff: _containers.RepeatedScalarFieldContainer[_MessageType_pb2.StudentBuffType]
    bullet_type: _MessageType_pb2.BulletType
    danger_alert: float
    determination: int
    facing_direction: float
    guid: int
    learning_speed: int
    player_id: int
    player_state: _MessageType_pb2.PlayerState
    prop: _containers.RepeatedScalarFieldContainer[_MessageType_pb2.PropType]
    radius: int
    rescue_progress: int
    score: int
    speed: int
    student_type: _MessageType_pb2.StudentType
    time_until_skill_available: _containers.RepeatedScalarFieldContainer[float]
    treat_progress: int
    treat_speed: int
    view_range: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., speed: _Optional[int] = ..., determination: _Optional[int] = ..., addiction: _Optional[int] = ..., time_until_skill_available: _Optional[_Iterable[float]] = ..., prop: _Optional[_Iterable[_Union[_MessageType_pb2.PropType, str]]] = ..., player_state: _Optional[_Union[_MessageType_pb2.PlayerState, str]] = ..., guid: _Optional[int] = ..., bullet_type: _Optional[_Union[_MessageType_pb2.BulletType, str]] = ..., learning_speed: _Optional[int] = ..., treat_speed: _Optional[int] = ..., player_id: _Optional[int] = ..., view_range: _Optional[int] = ..., radius: _Optional[int] = ..., danger_alert: _Optional[float] = ..., score: _Optional[int] = ..., treat_progress: _Optional[int] = ..., rescue_progress: _Optional[int] = ..., student_type: _Optional[_Union[_MessageType_pb2.StudentType, str]] = ..., facing_direction: _Optional[float] = ..., buff: _Optional[_Iterable[_Union[_MessageType_pb2.StudentBuffType, str]]] = ...) -> None: ...

class MessageOfTricker(_message.Message):
    __slots__ = ["buff", "bullet_type", "class_volume", "facing_direction", "guid", "player_id", "player_state", "prop", "radius", "score", "speed", "time_until_skill_available", "trick_desire", "tricker_type", "view_range", "x", "y"]
    BUFF_FIELD_NUMBER: _ClassVar[int]
    BULLET_TYPE_FIELD_NUMBER: _ClassVar[int]
    CLASS_VOLUME_FIELD_NUMBER: _ClassVar[int]
    FACING_DIRECTION_FIELD_NUMBER: _ClassVar[int]
    GUID_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ID_FIELD_NUMBER: _ClassVar[int]
    PLAYER_STATE_FIELD_NUMBER: _ClassVar[int]
    PROP_FIELD_NUMBER: _ClassVar[int]
    RADIUS_FIELD_NUMBER: _ClassVar[int]
    SCORE_FIELD_NUMBER: _ClassVar[int]
    SPEED_FIELD_NUMBER: _ClassVar[int]
    TIME_UNTIL_SKILL_AVAILABLE_FIELD_NUMBER: _ClassVar[int]
    TRICKER_TYPE_FIELD_NUMBER: _ClassVar[int]
    TRICK_DESIRE_FIELD_NUMBER: _ClassVar[int]
    VIEW_RANGE_FIELD_NUMBER: _ClassVar[int]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    buff: _containers.RepeatedScalarFieldContainer[_MessageType_pb2.TrickerBuffType]
    bullet_type: _MessageType_pb2.BulletType
    class_volume: float
    facing_direction: float
    guid: int
    player_id: int
    player_state: _MessageType_pb2.PlayerState
    prop: _containers.RepeatedScalarFieldContainer[_MessageType_pb2.PropType]
    radius: int
    score: int
    speed: int
    time_until_skill_available: _containers.RepeatedScalarFieldContainer[float]
    trick_desire: float
    tricker_type: _MessageType_pb2.TrickerType
    view_range: int
    x: int
    y: int
    def __init__(self, x: _Optional[int] = ..., y: _Optional[int] = ..., speed: _Optional[int] = ..., time_until_skill_available: _Optional[_Iterable[float]] = ..., prop: _Optional[_Iterable[_Union[_MessageType_pb2.PropType, str]]] = ..., tricker_type: _Optional[_Union[_MessageType_pb2.TrickerType, str]] = ..., guid: _Optional[int] = ..., score: _Optional[int] = ..., player_id: _Optional[int] = ..., view_range: _Optional[int] = ..., radius: _Optional[int] = ..., player_state: _Optional[_Union[_MessageType_pb2.PlayerState, str]] = ..., trick_desire: _Optional[float] = ..., class_volume: _Optional[float] = ..., facing_direction: _Optional[float] = ..., bullet_type: _Optional[_Union[_MessageType_pb2.BulletType, str]] = ..., buff: _Optional[_Iterable[_Union[_MessageType_pb2.TrickerBuffType, str]]] = ...) -> None: ...

class MessageToClient(_message.Message):
    __slots__ = ["all_message", "game_state", "obj_message"]
    ALL_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    GAME_STATE_FIELD_NUMBER: _ClassVar[int]
    OBJ_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    all_message: MessageOfAll
    game_state: _MessageType_pb2.GameState
    obj_message: _containers.RepeatedCompositeFieldContainer[MessageOfObj]
    def __init__(self, obj_message: _Optional[_Iterable[_Union[MessageOfObj, _Mapping]]] = ..., game_state: _Optional[_Union[_MessageType_pb2.GameState, str]] = ..., all_message: _Optional[_Union[MessageOfAll, _Mapping]] = ...) -> None: ...

class MoveRes(_message.Message):
    __slots__ = ["act_success", "actual_angle", "actual_speed"]
    ACTUAL_ANGLE_FIELD_NUMBER: _ClassVar[int]
    ACTUAL_SPEED_FIELD_NUMBER: _ClassVar[int]
    ACT_SUCCESS_FIELD_NUMBER: _ClassVar[int]
    act_success: bool
    actual_angle: float
    actual_speed: int
    def __init__(self, actual_speed: _Optional[int] = ..., actual_angle: _Optional[float] = ..., act_success: bool = ...) -> None: ...
