part of 'room_provider.dart';

/// 创建聊天室的描述文件
String _descfilePath;

/// 房间模式 true：主播模式 , false: 自由模式
bool _userMode;

/// 当前已加入房间信息
RoomListItemEntity _currentRoomDetails = RoomListItemEntity.create();

/// 房间创建人的房间信息 （todo 与 [RoomProvider]#[_currentRoomDetails]合并
MyRoomDetails _myRoomDetails;

/// 当前账号是否已创建聊天室
bool _haveRoom = false;

/// 聊天室中功能键文案
/// d:默认的icon [Image]#[asset(name)]
/// s:选中的icon
List _barInfo = [
  {
    "d": "miantiguan",
    "s": "miantikai",
    "title": "免提",
  },
  {
    "d": "guaduan",
    "s": "guaduan",
    "title": "退出",
  },
  {
    "d": "jingyinguan",
    "s": "jingyinkai",
    "title": "静音",
  },
  {
    "d": "Shape",
    "s": "Shape",
    "title": "提问",
  },
];

/// 聊天室中功能键状态缓存
List<bool> _states = List.generate(4, (index) => false);

/// 历史回放
List<HistoryListItemEntity> _historyList = List();

/// 全部房间
List<RoomListItemEntity> _roomList = List();

/// 搜索结果
List<RoomListItemEntity> _roomSearchList = List();

/// 收藏列表
List<RoomListItemEntity> _favList = List();

/// 全部房间数
String _roomCount = "";

/// 收藏房间数
String _favCount = "";

/// 创建聊天室界面打开状态
bool _openNewRoom = false;

/// 聊天室提问界面打开状态
bool _openQuestion = false;

/// 聊天室提问界面打开状态
bool _openQuestionSend = false;

int _roomListPage = 1;
int _roomSearchListPage = 1;
int _favListPage = 1;