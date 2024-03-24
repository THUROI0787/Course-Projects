from google.protobuf.internal import enum_type_wrapper as _enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from typing import ClassVar as _ClassVar

ADDICTED: PlayerState
ADD_AP: TrickerBuffType
ADD_HP_OR_AP: PropType
ADD_LIFE: StudentBuffType
ADD_LIFE_OR_CLAIRAUDIENCE: PropType
ADD_SPEED: PropType
ASSASSIN: TrickerType
ATHLETE: StudentType
ATOM_BOMB: BulletType
ATTACKING: PlayerState
A_NOISY_PERSON: TrickerType
BOMB_BOMB: BulletType
CHEST: PlaceType
CIRCLE: ShapeType
CLAIRAUDIENCE: TrickerBuffType
CLASSROOM: PlaceType
CLIMBING: PlayerState
COMMON_ATTACK_OF_TRICKER: BulletType
DESCRIPTOR: _descriptor.FileDescriptor
DOOR3: PlaceType
DOOR5: PlaceType
DOOR6: PlaceType
FLYING_KNIFE: BulletType
GAME_END: GameState
GAME_RUNNING: GameState
GAME_START: GameState
GATE: PlaceType
GRADUATED: PlayerState
GRASS: PlaceType
HIDDEN_GATE: PlaceType
IDLE: PlayerState
IDOL: TrickerType
JUMPY_DUMPTY: BulletType
KEY3: PropType
KEY5: PropType
KEY6: PropType
KLEE: TrickerType
LAND: PlaceType
LEARNING: PlayerState
LOCKING: PlayerState
NULL_BULLET_TYPE: BulletType
NULL_GAME_STATE: GameState
NULL_PLACE_TYPE: PlaceType
NULL_PLAYER_TYPE: PlayerType
NULL_PROP_TYPE: PropType
NULL_SBUFF_TYPE: StudentBuffType
NULL_SHAPE_TYPE: ShapeType
NULL_STATUS: PlayerState
NULL_STUDENT_TYPE: StudentType
NULL_TBUFF_TYPE: TrickerBuffType
NULL_TRICKER_TYPE: TrickerType
OPENING_A_CHEST: PlayerState
OPENING_A_GATE: PlayerState
QUIT: PlayerState
RECOVERY_FROM_DIZZINESS: PropType
RESCUED: PlayerState
RESCUING: PlayerState
ROBOT: StudentType
RUMMAGING: PlayerState
SHIELD: StudentBuffType
SHIELD_OR_SPEAR: PropType
SPEAR: TrickerBuffType
SQUARE: ShapeType
STRAIGHT_A_STUDENT: StudentType
STUDENT_ADD_SPEED: StudentBuffType
STUDENT_INVISIBLE: StudentBuffType
STUDENT_PLAYER: PlayerType
STUNNED: PlayerState
SUNSHINE: StudentType
SWINGING: PlayerState
TEACHER: StudentType
TECH_OTAKU: StudentType
TREATED: PlayerState
TREATING: PlayerState
TRICKER_ADD_SPEED: TrickerBuffType
TRICKER_INVISIBLE: TrickerBuffType
TRICKER_PLAYER: PlayerType
USING_SPECIAL_SKILL: PlayerState
WALL: PlaceType
WINDOW: PlaceType

class BulletType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class PlaceType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class ShapeType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class PropType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class StudentBuffType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class PlayerState(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class TrickerBuffType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class PlayerType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class StudentType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class TrickerType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []

class GameState(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []
