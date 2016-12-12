
#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const TitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const TitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const TopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const TopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const TopicCellBottomBarH;

/** 精华-cell-图片的最高高度 */
UIKIT_EXTERN CGFloat const TopicCellPictureMaxH ;
/** 精华-cell-图片高度超过一定时显示图片的固定高度 */
UIKIT_EXTERN CGFloat const TopicCellPictureBreaH;


/** UserModel-性别属性值 */
UIKIT_EXTERN NSString * const UserSexMale;

UIKIT_EXTERN NSString * const UserSexFemale;

/** 精华-最热评论-标题文字的最高高度 */
UIKIT_EXTERN CGFloat const TopicCellComTitleMaxH ;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const TabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const SelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const SelectedControllerKey;
/** 标签-text-间距 */
UIKIT_EXTERN CGFloat const TextMargin;
typedef enum
{
    man=1,
    women=2
}SEX;
/**
 帖子类型
 */
typedef  enum
{   TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41
} TopicType;