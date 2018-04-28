//
//  Mall_APIManager.h
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mall_APIManager : NSObject

/**
 *  网络接口调用规则：调用相关接口可按住alt左击接口方法，查看此接口可传入的参数有哪些，在参数的字典中可以传入除了service之外的参数,如果是否必填为“否”时，可以不进行填写，在回调block中进行返回数据的处理。详情查看《APP接口开发规范文档》
 *
 *  @see 后期优化将使用model替代接口中得params字典
 *  @return 网络请求单例
 */
+ (instancetype)sharedManager;

/**
 *  接口eoapi测试请求
 *
 *  @param block 回调block
 */
-(void)request_eoapi:(NSString*)urlStr andBlock:(void(^)(id data,NSError* error))block;

/**
 *  接口3.1.1 基本封装的请求
 *
 *  @param block 回调block
 */
-(void)baseRequest_CustomeParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  判断网络连接情况
 *
 *  @return True为网络连接状态，False为网络未连接状态
 */
-(BOOL)isNetworkReachable;

/**
 *  接口3.1.1 首页主广告位接口（Ad.IndexBanner)
 *
 *  @param block 回调block
 */
- (void)request_IndexBannerWithBlock:(void (^)(id data, NSError *error))block;

/**
 *  3.1.2 百度广告联盟 Ad.BaiduAd
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	Ad.BaiduAd	string	接口调用api名称
 */
-(void)request_Ad_BaiduAdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.1.3 活动的视频广告 Ad.VideoAd
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Ad.VideoAd	string	接口调用api名称
 */
-(void)request_Ad_VideoAdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.1.4 活动的商品广告
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	Ad.GoodsAd	string	接口调用api名称
 */
-(void)request_Ad_GoodsAdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.3.1 活动商品列表接口
 * @param 序号	请求方式	必填	名称	类型	描述
 * @param  1	GET	是	Task.TaskList	string	接口调用api名称
 * @param  2	POST	否	sort	string	"活动商品排序规则
 可选值：{goods_id (综合), Click_count （人气）, update_time （更新时间）,red_campbell （奖励） } 默认值为:综合"
 * @param  4	POST	否	page_num	int	当前的页数，默认值为：0
 * @param  5	POST	否	page_size	int	"每页显示的数量
 默认值为：10"
 * @param  6	POST	否	task_margin	int	"活动筛选:活动保证金（元）。
 默认为0（全部）
 可选值：
 { 0:全部 1:0-1000 2：10001-50000 3：50001-100000 4：100001-500000 5：500001以上
 }"
 * @param  7	POST	否	task_days	int	"活动筛选：活动天数
 默认值为：0(全部)
 可选值：
 { 0：全部 1：0-5 2：5-10 3：11-30 4：30以上 }"
 * @param  8	POST	否	task_type	int	"活动类型：
 默认为空，取得所有活动。
 可选值
 {
 0：分享活动
 1：邀请活动
 2：看商品活动
 3：浏览活动
 }"
 * @param  9	POST	否	re_type	String	"推荐活动类型，默认为空
 可选值：
 {
 hot：热门活动
 best：精品活动
 new：最新活动
 }"
 * @param  10	POST	否	keywords	string	搜索关键词
 *  @param block  回调block
 */
-(void)request_TaskListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.3.2 活动详情接口（Task.TaskDetail)
 
 * @param 序号	请求方式	必填	名称	类型	描述
 * @param  1	GET	是	Task.TaskDetail	string	接口调用api名称
 * @param  2	POST	是	goods_id	int	活动id
 *
 */
-(void)request_TaskDetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.3.3 领取活动接口 Task.ReceiveTask
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Task.ReceiveTask	string	接口调用api名称
 *  @param params 2	POST	是	goods_id	int	活动id
 *  @param params 3	POST	否	user_id	int	用户的id
 *  @param params 4	POST	否	sessionkey	string	用户sessionkey
 *  @param params 5	POST	是	reward_level	string	领取奖励级别（分享次数）
 *  @param params  6	POST	否	uservoucher_id	int	用户代金券 id
 */
-(void)request_ReceiveTaskWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.4.1文章列表接口-- Article.AList
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	Article.AList	string	接口调用api名称
 *  @param 2	POST	否	num	int	"调用文章的数量的数量 默认值为：5"
 *  @param 3	POST	是	a_type	String	"广告类型：
 可选值:
 {
 index_notice：(首页公告)
 
 }"
 */
-(void)request_ArticleListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.4.2 文章列表接口
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Article.Index	string	接口调用api名称
 *  @param  2	POST	是	page_num	int	第几页
 *  @param  3	POST	是	page_size	int	每页个数
 *  @param  4	POST	是	cate_id	int	"栏目的id 公告-32"
 */
-(void)request_Article_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  3.5.1活动评论列表接口   TaskComment.Index
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	TaskComment.Index	string	接口调用api名称
 *  @param 2	POST	是	goods_id	int	活动商品的id
 *  @param 3	POST	是	page_num	int	第几页
 *  @param 4	POST	是	page_size	int	每页的数量
 */
-(void)request_TaskComment_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.5.2 活动评论添加接口 TaskComment.Add
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	TaskComment.Index	string	接口调用api名称
 *  @param params 2	POST	是	goods_id	int	活动商品的id
 *  @param params 3	POST	是	content	string（280）	评论内容，最大长度280
 *  @param params 4  POST    是   sessionkey  string 用户sessionkey
 *  @param params 5  POST    是   user_id     int     用户的id
 */
-(void)request_TaskComment_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.5.3 评论总数  TaskComment.CountNum
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	TaskComment.CountNum	string	接口调用api名称
 *  @param params 2	POST	是	goods_id	int	活动商品的id
 */
-(void)request_TaskComment_CountNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.1用户登录接口（User.Login)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	User.Login	string	接口调用api名称
 *  @param 2	POST	是	username	string	用户名称
 *  @param 3	POST	是	passwd	string	登录密码MD5(32位)
 *  @param 4	POST	否	captcha	String	验证码
 */
-(void)request_LoginWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.2 用户登出接口（User.Logout)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	User.Logout	string	接口调用api名称
 *  @param 2	POST	是	user_id	int	用户id
 *  @param 3	POST	是	sessionkey	string	登入时返回的用户凭证/令牌
 */
-(void)request_LogoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.3 获取手机验证码接口（User.MCode)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	User.MCode	string	接口调用api名称
 *  @param 2	POST	是	mobile_phone	string	手机号
 添加参数 is_forget
 是否是在忘记密码页面时使用（验证手机号用户是否存在）
 添加参数 is_register
 是否是在注册页面时使用
 （注册是需要验证手机号是否已注册）
 1 是
 其他 否
 */
-(void)request_MCodeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.4用户注册接口（User.Register)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	User.Register	string	接口调用api名称
 *  @param  2	POST	是	mobile_phone	string	手机号
 *  @param  3	POST	是	passwd	string	用户注册密码md5(32)
 *  @param  4	POST	是	m_code	string	短信验证码
 *  @param  5	POST	否	parent_id	Int	推荐人用户user_id
 */
-(void)request_RegisterWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.5 个人中心-获取用户基本信息 UserCenter.UserInfo
 *
 *  @param   序号	请求方式	必填	名称	类型	描述
 *  @param   1	GET	是	User.UserInfo	string	接口调用api名称
 *  @param   2	POST	是	user_id	int	用户id
 *  @param   3	POST	是	sessionkey	string	登入时返回的用户凭证/令牌
 */
-(void)request_UserInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.6 忘记密码 User.Forget
 *  
 *描述：passwd为空 为验证 验证码是否正确 接口
 * passwd不为空 为验证通过后重新设置密码
 *
 *  @param param 序号	请求方式	必填	名称	类型	描述
 *  @param param 1	GET	是	User.Forget	string	接口调用api名称
 *  @param param 2	POST	是	mobile	string	手机号
 *  @param param 3	POST	是	sms_code	string	短信验证码
 *  @param param 4	POST	否	passwd	string（32）	md5新的登录密码
 */
-(void)request_User_ForgetWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.7 是否实名认证和设置支付密码  UserCenter.CheckRealname
 *  #调用时注意，只有在登录状态下才可以调用此方法#
 *  @param params 可以传任意值，在请求方法中不会使用
 *  @param params    序号	请求方式	必填	名称	类型	描述
 *  @param params    1	GET	是	UserCenter.CheckRealname	string	接口调用api名称
 *  @param params    2	POST	是	user_id	int	用户id
 *  @param params    3	POST	是	sessionkey	string	sessionkey
 */
-(void)request_UserCenter_CheckRealnameWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.8 是否可以修改用户名和修改用户名 UserCenter.EditInfo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserCenter.CheckRealname	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	new_username	string	"新的用户名
 * 不穿值-检测是否允许修改
 *传值-修改用户名"
 */
-(void)request_UserCenter_EditInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.8_2 上传用户头像 UserCenter.UploadHeadimg
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserCenter.UploadHeadimg	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	upFile	file  "POST 文件流限制：格式：jpg gif png 大小：3M"
 */
-(void)request_UserCenter_UploadHeadimgWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.9 修改用户资料 UserCenter.EditUserinfo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserCenter.EditUserinfo	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	sex	enum	"1:保密 2: 男  3: 女"
 *  @param  5	POST	否	birthday	string	格式2016-05-01
 *  @param  6	POST	否	head_img	string	图片的远程地址
 */
-(void)request_UserCenter_EditUserinfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.6.11 验证支付密码（UserCenter.AuthPayPasswd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserCenter.AuthPayPasswd	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	pay_passwd	string	md5(支付密码)
 */
-(void)request_UserCenter_AuthPayPasswdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.7.1 个人资产汇总
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 */
-(void)request_MoneyIndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.7.2 个人资产明细
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	money_type	string	钱币类型 money|points
 *  @param params 5	POST	是	page_num	Int	第几页
 *  @param params 6	Post	是	page_size	int	每页的个数
 */
-(void)request_MoneyDetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.1 银行卡列表 Bank.Index
 *
 *  @param params  序号	请求方式	必填	名称	类型	描述
 *  @param params  1	GET	是	Money.index	string	接口调用api名称
 *  @param params  2	POST	是	user_id	string	用户id
 *  @param params  3	POST	是	sessionkey	string	登录sessenkey
 *  @param params  4	POST	否	is_default	int	是否至返回默认的银行卡，否返回所用的卡
 */
-(void)request_Bank_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.2 银行卡实名认证 Bank.Realnameauth
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Money.index	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	   是	name	string	姓名
 *  @param  5	POST	是	card_number	string	身份证号
 */
-(void)request_Bank_RealNameAuthWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.3 添加银行卡 Bank.Add
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	Money.index	string	接口调用api名称
 *  @param 2	POST	是	user_id	string	用户id
 *  @param 3	POST	是	sessionkey	string	登录sessenkey
 *  @param 4	POST	   是	bank_type	int	银行的类型,参考表bank_code
 *  @param 5	POST	是	card_code	string	卡号
 *  @param 6	POST	是	mobile	string	银行预留手机号
 *  @param 7	POST	是	bank_address	string	"银行区域，-分割 格式：山东-临沂市-兰山区-银雀山路50号"
 *  @param 8	POST	是	type_type	string	C =信用卡  D =借记卡
    @param 9	POST	否	card_exp	string	银行卡有效期 如果有效期是11/12，则填写格式为1112
    @param 10	POST	否	card_cvv2	string	校验码是信用卡背面的4位数字
 */
-(void)request_Bank_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.4 银行卡的信息   Bank.CardInfo
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Bank.CardInfo	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	card_number	string	银行的卡号
 */
-(void)request_Bank_CardInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.5 银行卡是否已添加 Bank.CardIsExist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Bank.CardIsExist	string	接口调用api名称
 *  @param  2	POST	   是	card_number	string	银行的卡号
 */
-(void)request_Bank_CardIsExistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.6 支持银行列表  Bank.SupportBank
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Bank.SupportBank	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 */
-(void)request_Bank_SupportBankWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.7 设置默认银行卡 Bank.SetDefault
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Bank.SetDefault	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	card_number	string	卡号
 */
-(void)request_Bank_SetDefaultWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.8.7 删除银行卡 Bank.Delete
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Bank.Delete	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	card_number	string	卡号
 */
-(void)request_Bank_DeleteWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.9.1 提现 Takecash.Take
 *
 *  @param
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param 1	GET	是	Money.index	string	接口调用api名称
 *  @param 2	POST	是	user_id	string	用户id
 *  @param 3	POST	是	sessionkey	string	登录sessenkey
 *  @param 4	POST	是	number	float	提现额度
 *  @param 5	POST	是	money_type	enum	货币类型money 或 points
 *  @param 6	POST	是	pay_passwd	string	支付密码
 *  @param 7    POST    是   card_id init    银行卡记录bank_id
 */
-(void)request_Takecash_TakeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.9.2 银行卡转账 Takecash.Transfer
 *
 *  @param params
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	number	float	额度
 *  @param params 5	POST	是	money_type	enum	货币类型money 或 points
 */
-(void)request_Takecash_TransferWithParams:(NSDictionary*)params andBloc:(void(^)(id data,NSError* error))block;

/**
 *  3.9.3 充值 Takecash.Recharge
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	number	float	额度
 *  @param params 5	POST	是	card_id	string	使用银行卡的id
 */
-(void)request_Takecash_RechargeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.9.4 确认充值支付 Takecash.Payment
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	sms_code	string	银行短信校验码
 *  @param params 5	POST	是	card_id	string	使用银行卡的id
 *  @param params 6	POST	是	log_id	int	充值接口返回的记录log_id
 */
-(void)request_Takecash_PaymentWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.1 活动列表 Usertask.Index
 *
 *  @param params
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	type	int	"活动状态0-进行中 1-成功 2-失败"
 *  @param params 5	POST	否	today_success	enum	（属于进行中子状态） 0-今天未完成 1-今天已完成 2-全部进行中
 *  @param params 6	POST	是	page_num	int	第几页
 *  @param params 7	POST	是	page_size	int	每页个数
 *  @return data中status详细状态的说明 0-今日未完成 1-今日已完成 2-活动全部完成 3-活动失败
 */
-(void)request_Usertask_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.2 活动详情 Usertask.Detail
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	id	int	活动订单的id
 */
-(void)request_UserTask_DetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.3 开始活动 Usertask.Start
 *
 *  @param pararms 序号	请求方式	必填	名称	类型	描述
 *  @param pararms 1	GET	是	Money.index	string	接口调用api名称
 *  @param pararms 2	POST	是	user_id	string	用户id
 *  @param pararms 3	POST	是	sessionkey	string	登录sessenkey
 *  @param pararms 4	POST	是	id	int	活动订单的id
 */
-(void)request_Usertask_StartWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.10.4 完成活动 Usertask.Complete
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	id	int	活动订单的id
 */
-(void)request_Usertask_CompleteWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.5  结束活动 Usertask.End
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	id	int	活动订单的id
 */
-(void)request_Usertask_EndWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.6 是否可以展期 Usertask.IsRenewal
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Usertask.IsRenewal	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	task_id	int	任务订单的id
 */
-(void)request_Usertask_IsRenewalWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.10.7 展期活动 Usertask.Renewal
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Usertask.IsRenewal	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	task_id	int	任务订单的id
 */
-(void)request_Usertask_RenewalWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  3.11.1 后台模块配置参数列表 Config.Index
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	module_name	string	"模块名，已知模块名列表 ，其他根据需求开发
 takecash-提现
 transfer-转账"
 *  @param params 3	POST	否	money_type	enum	货币类型（如果模块没有则不传值）money | points
 */
-(void)request_Config_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.12.1 我的邀请信息 Team.Spread
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	id	int	活动订单的id
 */
-(void)request_Team_SpreadWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError * error))block;

/**
 *  3.12.2 推广列表 Team.Affiliate
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Money.index	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	type	enum	活动状态0-推荐明细  1-奖励明细
 *  @param params 5	POST	是	page_num	int	第几页
 *  @param params 6	POST	是	page_size	int	每页个数
 */
-(void)request_Team_AffiliateWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.13.1  设置登录密码 Setting.SetPasswd
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Setting.SetPasswd	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	passwd	string	新密码的MD5
 */
-(void)request_Setting_SetPasswdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.13.2 设置或修改支付密码 Setting.SetPaypasswd
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Setting.SetPaypasswd	string	接口调用api名称
 *  @param params 2	POST	是	user_id	string	用户id
 *  @param params 3	POST	是	sessionkey	string	登录sessenkey
 *  @param params 4	POST	是	passwd	string	新密码的MD5
 *  @param params 5	POST	是	sms_code	string	手机验证码
 */
-(void)request_Setting_SetPaypasswdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.13.3 更换手机号 Setting.SetMobile
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Setting.SetMobile	string	接口调用api名称
 *  @param  2	POST	是	user_id	string	用户id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	mobile	string	新的手机号
 *  @param  5	POST	是	sms_code	string	手机验证码
 */
-(void)request_Setting_SetMobileWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.14.1 协议内容
 *
 *  @param params 序号	请求方式	必填	名称	类型	描述
 *  @param params 1	GET	是	Agreement.Detail	string	接口调用api名称
 *  @param params 2	POST	是	name	string	"协议标识
 register-注册
 bank-添加银行卡
 about-关于我们"
 */
-(void)request_Agreement_DetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.15.1 清除api中商城参数文件缓存  Cache.ShopConfigClear
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Cache.ShopConfigClear	string	接口调用api名称
 */
-(void)request_Cache_ShopConfigClearWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.16.1 分享信息   Share。Index
 *
 * 描述：
 * 1.分享活动商品情况  	所需参数
 * 用户未登录 			goods_id
 * 用户已登录 			goods_id  user_id
 *	2.我的活动中 分享活动    task_id
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Share.Index	string	接口调用api名称
 *  @param  2	POST	否	user_id	int	用户id
 *  @param  3	POST	否	goods_id	int	活动商品的id
 *  @param  4	POST	否	task_id	int	我的活动的id
 */
-(void)request_Share_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.16.2 我的邀请-分享信息  Share.Spread
 *
 *  @param   序号	请求方式	必填	名称	类型	描述
 *  @param   1	GET	是	Share.Index	string	接口调用api名称
 *  @param   2	POST	否	user_id	int	用户id
 */
-(void)request_Share_SpreadWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *   3.17.1 检测是否有最新版本(Version.IsNew)
 *
 *   @param  序号    请求方式   必填   名称  类型  描述
 *   @param  1       GET       是 Version.IsNew  string 接口调用api名称
 ＊  @param  2       POST      是  cur_version  string  当前的版本 格式：安卓 and-1.2  iOS   ios-1.2
 */
-(void)request_Check_Version_Update:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.18.1 红筹列表专场 Chips.Index
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Chips.Index	string	接口调用api名称
 *  @param  2	POST	是	page_num	int	"min=1 当前第几页"
 *  @param  3	POST	是	page_size	int	每页页数
 *  @param  4	POST	否	type	string	"best – 推荐红筹 空 –不限制"
 */
-(void)request_Chips_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.18.2 红筹详情  Chips.Detail
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Chips.Detail	string	接口调用api名称
 *  @param  2	POST	是	chips_id	int	红筹的id
 */
-(void)request_Chips_DetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.18.3 领取红筹 Chips.GetChips
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Chips.GetChips	string	接口调用api名称
 *  @param  2	POST	是	chips_id	int	红筹的id
 *  @param  3	POST	是	user_id	int	用户id
 *  @param  4	POST	是	sessionkey	str（32）	用户sessionkey
 *  @param  5	POST	是	num	int	领取数量
 *  @param  6	POST	是	pay_passwd	string	md5（支付密码）
 *  @param  7	POST	否	uservoucher_id	int	用户代金券 id
 */
-(void)request_Chips_GetChipsWithParams:(NSDictionary*) params andBlock:(void(^)(id data,NSError*error))block;

/**
 *  3.18.4 红筹问答 (Chips.GetQa)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Chips.GetQa	string	接口调用api名称
 */
-(void)request_Chips_GetQaWithParams:(NSDictionary*) params andBlock:(void(^)(id data,NSError*error))block;

/**
 *  3.19.1 我的红筹列表 Userchips.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Userchips.Index	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	用户sessionkey
 *  @param  4	POST	是	page_num	int	"min=1 当前第几页"
 *  @param  5	POST	是	page_size	int	每页页数
 *  @param  6	POST	是	type	enum	"1– 红筹中 2 –已结束"
 */
-(void)request_Userchips_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError*error))block;

/**
 *  3.19.2 我的红筹详细 Userchips.Detail
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Userchips.Detail	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户id
 *  @param  3	POST	是	sessionkey	string	用户sessionkey
 *  @param  4	POST	是	order_id	int	红筹订单的id
 */
-(void)request_Userchips_DetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError*error))block;

/**
 *  3.19.3  红筹结束 Userchips.End
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Chips.GetChips	string	接口调用api名称
 *  @param  2	POST	是	order_id	int	红筹的id
 *  @param  3	POST	是	user_id	int	用户id
 *  @param  4	POST	是	sessionkey	str（32）	用户sessionkey
 */
-(void)request_Userchips_EndWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.19.4 我的红筹展期 Userchips.Renewal
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Userchips.Renewal	string	接口调用api名称
 *  @param  2	POST	是	order_id	int	红筹的id
 *  @param  3	POST	是	user_id	int	用户id
 *  @param  4	POST	是	sessionkey	str（32）	用户sessionkey
 */
-(void)request_Userchips_RenewalWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.20.1 红筹评论列表 ChipsComment.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	ChipsComment.Index	string	接口调用api名称
 *  @param  2	POST	是	goods_id	int	红筹的id
 *  @param  3	POST	是	page_num	int	第几页
 *  @param  4	POST	是	page_size	int	每页的数量
 */
-(void)request_ChipsComment_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.20.2 评论总数 ChipsComment.CountNum
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	ChipsComment.CountNum	string	接口调用api名称
 *  @param  2	POST	是	goods_id	int	商品的id
 */
-(void)request_ChipsComment_CountNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.20.3 评论添加接口 ChipsComment.Add
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	ChipsComment.Add	string	接口调用api名称
 *  @param  2	POST	是	goods_id	int	商品的id
 *  @param  3	POST	是	content	string（280）	评论内容，最大长度280，中文、符号、英文字母都算作一个
 *  @param  5	POST	是	user_id	int	用户的id
 *  @param  6	POST	是	sessionkey	string	用户sessionkey
 */
-(void)request_ChipsComment_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.21.1 开始签到 Sign.StartSign
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Sign.StartSign	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户的id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 */
-(void)request_Sign_StartSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.21.2 完成签到 Sign.CompleteSign
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Sign.CompleteSign	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户的id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 */
-(void) request_Sign_CompleteSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.22.1 我的代金券列表 UserVoucher.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserVoucher.Index	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户的id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	page_num	int	第几页，min=1
 *  @param  5	POST	是	page_size	int	每页页数
 */
-(void)request_UserVoucher_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.22.2 选取代金券列表（UserVoucher.Select
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	UserVoucher.Select	string	接口调用api名称
 *  @param  2	POST	是	user_id	int	用户的id
 *  @param  3	POST	是	sessionkey	string	登录sessenkey
 *  @param  4	POST	是	module	enum	"module类型 chips-红筹 task-活动"
 *  @param  5	POST	是	goods_id	int	商品的id
 */
-(void) request_UserVoucher_SelectWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

#pragma mark - 商城模块接口

/**
 *  3.23 首页专柜特区 (Category.cateGoriesse)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Category.cateGoriesse	string	接口调用api名称
 *  @param  2	POST	否	cat_id	int	分类id 默认0
 *  @param  3	POST	否	limit	Int	数量 默认5
 */
-(void)request_Category_cateGoriesseWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

//TODO: 有待更新
-(void)request_Index_everyGroupWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.25 首页猜您喜欢 (Index.bestGoods)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param   1	GET	是	Index.bestGoods	string	接口调用api名称
 *  @param   2	POST	否	limit	Int	数量 默认 5
 */
-(void)request_Index_bestGoodsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.26 商品详情 (Goods.getGoodInfo)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param   1	GET	是	Goods.getGoodInfo	string	接口调用api名称
 *  @param   2	POST	是	id	Int	 商品id
 */
-(void)request_Goods_getGoodInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.27 商品属性 (Goods.getGoodsProperties)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Goods.getGoodsProperties	string	接口调用api名称
 *  @param  2	POST	是	id	Int	 商品id
 */
-(void)request_Goods_getGoodsPropertiesWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.28 商品评论 (Goods.getComment)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Goods.getComment	string	接口调用api名称
 *  @param  2	POST	是	id	Int	 商品id
 *  @param  3	POST	否	pageSize	Int	 条数
 *  @param  4	POST	否	pageNow	Int	当前页
 */
-(void)request_Goods_getCommentWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.29 商品评论 (Goods.getCommentNum)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Goods.getCommentNum	string	接口调用api名称
 *  @param  2	POST	是	id	Int	 商品id
 */
-(void)request_Goods_getCommentNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.30 专柜商品 (Category.getCateGoods)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Category.getCateGoods	string	接口调用api名称
 *  @param  2	POST	否	cat_id	Int	 商品分类id
 *  @param  3	POST	否	page	Int	   第几页
 *  @param  4	POST	否	pageSize	Int	    数量
 *  @param  5	POST	否	sort	String	"order_sum  销量|  comment_sum评论数| last_update 上架时间| shop_price  价格"
 *  @param  6	POST	否	order	String	"ASC DESC"
 *  @param  7	POST	否	group	Int	  "1  团购商品 0  所有商品 (默认)"
 *  @param  8	POST	否	user_id	Int	  有值才会返回返利金额
 *  @param  9	POST	否	keywords	String	搜索关键词
 *  @param  10	POST	否	group_limited	1   限量秒杀  0不是限量秒杀(默认)本属性只对团购有效
 */
-(void)request_Category_getCateGoodsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.31 商家信息 (Suppliers.getInfo)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Suppliers.getInfo	string	接口调用api名称
 *  @param  2	POST	否	suppliersId	Int 	商家id
 */
-(void)request_Suppliers_getInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.32 商家信息 (Goods.getPrice)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Goods.getPrice	string	接口调用api名称
 *  @param  2	POST	否	id	Int 	商品id
 *  @param  3	POST	否	attr	String	"属性id 例:141077,141082"
 *  @param  4	POST	否	type	String	"group 团购商品"
 */
-(void)request_Goods_getPriceWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.33 加入购物车 (Flow.add_to_cartNew)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.add_to_cartNew	string	接口调用api名称
 *  @param  2	POST	是	goods_id	Int 	商品id
 *  @param  3	POST	是	spec	String	"属性id 例:143979,143981"
 *  @param  4	POST	是	number	Int	数量
 *  @param  5	POST	是	user_id	String	"group 团购商品"
 *  @param  6	POST 	是	sessionkey	String	Sessionkey
 */
-(void)request_Flow__add_to_cartWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.34 查看购物车 (Flow.index)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.index	string	接口调用api名称
 *  @param  2	POST	否	user_id	Int 	商品id
 *  @param  3	POST	否	sessionkey	String	Sessionkey
 */
-(void)request_Flow_indexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.34 广告 (Ads.getAds)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Ads.getAds	string	接口调用api名称
 *  @param  2	POST	是	rec_id	Int 	购物车id
 *  @param  3	POST	否	num	String	数量 (默认全部)
 */
-(void)request_Ads_getAdsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.35 删除购物车商品 (Flow.drop_goods)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.drop_goods	string	接口调用api名称
 *  @param  2	POST	是	ads_id	Int 	广告位id
 *  @param  3	POST	是	user_id	Int 	用户id
 *  @param  4	POST	是	sessionkey	String	Sessionkey
 */
-(void)request_Flow__drop_goodsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.36 收货地址列表 (Address.getList)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Address.getList	string	接口调用api名称
 *  @param  2	POST	是	user_id	Int 	商品id
 */
-(void)request_Address_getListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.37 省级市 (Address.regions)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Address.regions	string	接口调用api名称
 *  @param  2	POST	否	id	Int 	Id
 *  @param  3	POST	否	type	Int	"0 返回当前id的子集 |  1 返回自己的信息"
 */
-(void)request_Address_regionsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.38 修改/添加收货地址 (Address.act_edit_address)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Address.act_edit_address	string	接口调用api名称
 *  @param  2	POST	是	user_id	Int 	  会员id
 *  @param  3	POST	否	address_id	Int	" 地址编号 为空 添加收货地址 不为空 修改地址|||添加收货地址做多五条"
 *  @param  4	POST	是	country	Int	  国家
 *  @param  5	POST	是	province	Int	  省
 *  @param  6	POST	是	city	Int	  县
 *  @param  7	POST	是	district	Int	  街道
 *  @param  8	POST	是	address	String	 详细地址
 *  @param  9	POST	是	consignee	String	收货地址
 *  @param  10	POST	是	email	String	邮箱
 *  @param  11	POST	是	mobile	String	手机
 *  @param  12	POST	否	tel	String	电话
 *  @param  13	POST	否	best_time	String	最佳送货时间
 *  @param  14	POST	否	sign_building	String	标志建筑
 *  @param  15	POST	否	zipcode	String	邮编
 */
-(void)request_Address__act_edit_addressWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.39 默认收货地址 (Address.def)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Address.def	string	接口调用api名称
 *  @param  2	POST	是	user_id	Int 	  会员id
 *  @param  3	POST	是	address_id	Int	 地址编号
 */
-(void)request_Address_defWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.40 删除收货地址 (Address.del)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Address.del	string	接口调用api名称
 *  @param  2	POST	是	user_id	Int 	  会员id
 *  @param  3	POST	是	address_id	Int	 地址编号
 */
-(void)request_Address_delWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.41 购物车提交 (Flow.checkout)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.checkout	string	接口调用api名称
 *  @param  2	POST	是	user_id	Int 	  会员id
 *  @param  3	POST	是	sessionkey	Int	 sessionkey
 */
-(void)request_Flow_checkoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.42 订单支付 (Flow.done)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.done	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	Int	 sessionkey
 *  @param  4	POST	是	selected_address_id	 Int	 收货地址id
 *  @param  5	POST	是	shipping	Array	 配送方式
    shipping 配送方式
    传值为数组的形式  :
    extend_shipping[]= 335,3     335 为店铺的id   3 为快递id (shipping_id)
    extend_shipping[]= 0,3         0 为店铺的id   3 为快递id
 *  @param  6	POST	是	payment_id	 Int	 传值1 为余额支付  现在只能传值1
 *  @param  7	POST	否	payment	  string	 支付方式现在不用管他 , 以后扩展
 *  @param  8	POST	是	bonus	  Int	 选择的红包id
 *  @param  9	POST	是	p_password	  string	 支付密码
 */
-(void)request_Flow_doneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.43 选择红包./快递 价格变动 (Flow.change)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Flow.change	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	selected_address_id	 Int	 收货地址id
 *  @param  5	POST	是   bonus	  Int	 选择的红包id
 *  @param  6	POST	是	shipping	 Array	 配送方式
    shipping 配送方式
    传值为数组的形式  :
    extend_shipping[]= 335,3     335 为店铺的id   3 为快递id (shipping_id)
    extend_shipping[]= 0,3         0 为店铺的id   3 为快递id
 */
-(void)request_Flow_changeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.44 搜索 (Search.lists)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Search.lists	  string	接口调用api名称
 *  @param  2	POST	否	keywords	   String 	  关键字
 *  @param  3	POST	否	user_id	 Int	 会员id有参数才会显示商品的返利金额
 *  @param  4	POST	否	page	 Int	 第几页每页默认10条
 *  @param  5	POST	否   sort	  string	 goods_id 综合 , order_sum  销量
    ,comment_sum评论数 ,last_update 上架时间,shop_price  价格
 *  @param  6	POST	否	order	 String	 ASC  低->高   DESC   高->低
 *  @param  7	POST	否	category	 Int	  专柜id
 */
-(void)request_Search_listsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.45 个人中心 (Member.index)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Member.index	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 */
-(void)request_Member_indexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.46 我的收藏 (Collection.lists)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Collection.lists	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	page	 Int	 第几页每页默认十条
 */
-(void)request_Collection_listsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.47 加入收藏 (Collection.collect)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Collection.collect	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	id	 Int	 商品id
 */
-(void)request_Collection_collectWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.48 删除收藏 (Collection.delete)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Collection.delete	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	lection_id	 Int	 收藏id (rec_id)
 */
-(void)request_Collection_deleteWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.49 我的订单 (Member.orderList)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Member.orderList	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	page	 Int	 第几页
 *  @param  5	POST	否	pagesize	 Int	 数量
 *  @param  6	POST	否	page	 Int	 1  所有订单，2   待付款，3   待发货，4   待收货，5   待评论
 */
-(void)request_Member_orderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.50 确认收货 (Member.affirmReceived)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Member.affirmReceived	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	order_id	 Int	 订单id
 */
-(void)request_Member_affirmReceivedWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.51 买家评论(Member.comment)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Member.comment	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	order_id	 Int	 订单id
 *  @param  5	GET	    是	comment_rank	Array	评论等级 候选值 1    差评 3 中评 5    好评  comment_rank[‘6801’]=1   6801为订单中 goods 下面 rec_id , 当订单中存在多个商品 , 请全部全传入对应值
 *  @param  6	POST	是	comment_score_describe	   Array 	  宝贝与描述相符 1-4分
 *  @param  7	POST	是	comment_score_service	 Array	 卖家的服务态度 1-3分
 *  @param  8	POST	是	comment_score_speed	 Array	 卖家的发货速度 1-3分
  *  @param 9	POST	是	content	 Array	 评论内容
 */
-(void)request_Member_commentWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.52 退/换货订单列表 (Order.returnList)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.returnList	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	size	 Int	 数量
 *  @param  5	POST	否	size	 Int	 第几页
 */
-(void)request_Order_returnListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.53 取消退/换货(Order.cancelReturn)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.cancelReturn	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	ret_id	 Int	 退/换货订单id(退/换货订单列表中的ret_id)
 */
-(void)request_Order_cancelReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.54 申请退/换货列表 (Order.applyReturn)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.applyReturn	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	order_id	 Int	订单id
 *  @param  5	POST	是	ret_id	 Int	 订单列表返回参数中(rec_id)
 */
-(void)request_Order_applyReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.55 退/换货提交 (Order.submitReturn)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.submitReturn	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	order_id	 Int	订单id
 *  @param  5	POST	是	ret_id	 Int	 订单列表返回参数中(rec_id)
 *  @param  6	GET	    是	check_return	  Int	1 代表退货 2 代表换货
 *  @param  7	POST	是	goods_id	   Int 	  商品id
 *  @param  8	POST	是	return_num	 Int	 退/换货数量
 *  @param  9	POST	否	remark	 String	  退/换货原因
 *  @param  10	POST	否	img_name	  String	 图片凭证(url链接地址)
 */
-(void)request_Order_submitReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.56 我的红包 (Member.onBonus)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Member.onBonus	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	否	status	 Int	1 未使用 (默认) 2 已使用 3 已过期
 *  @param  5	POST	否	page	 Int	 第几页(默认1)
 *  @param  6	POST	否	size	 Int	 数量(默认10)
 */
-(void)request_Member_onBonusWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.57 物流跟踪 (Kuaidiapi.getLogistics)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Kuaidiapi.getLogistics	  string	接口调用api名称
 *  @param  2	POST	是	order_id	   Int 	  快递单号(订单中invoice_no)
 *  @param  3	POST	是	id	 Int	 快递id(订单中shipping_id)
 *  @param  4	POST	否	order	 String  	asc    升序   desc   降序
 */
-(void)request_Kuaidiapi_getLogisticsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.58 订单详情 (Order.orderDetail)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.orderDetail	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	order	 Int	订单id
 */
-(void)request_Order_orderDetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.59 分类预览页 (Category.getCates)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Category.getCates	  string	接口调用api名称
 *  @param  2	POST	否	cat_id	   Int 	  0   获取所有二级分类 99999 获取推荐分类其他cat_id  返回三级分类
 */
-(void)request_Category_getCatesWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.59 提醒卖家发货 (Order.deliver)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.deliver	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 string	 sessionkey
 *  @param  4	POST	是	order_id	 Int	订单id
 *  @param  5	POST	是	suppliers_id	 Int	 商家id
 */
-(void)request_Order_deliverWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.60 公告通知 (Article.Index)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Article.Index	  string	接口调用api名称
 *  @param  2	POST	是	page_num	   Int 	  第几页
 *  @param  3	POST	是	page_size	 int	 每页个数
 *  @param  4	POST	是	cate_id	 Int	栏目的id公告-32
 *  @param  5	POST	否	keywords	 String	 搜索关键字
 */
-(void)request_Article_IndexParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.61 我的投诉列表 (Order.complaintsList)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.complaintsList	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 int	 sessionkey
 */
-(void)request_Order_complaintsListParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.62 投诉提交 (Order.addComplaints)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.addComplaints	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	complanint_order	 Int	 要投诉的订单id
 *  @param  5	POST    是	complanint_type	  Int	1= 产品相关；2= 价格相关；3= 服务相关；4= 物流相关；5= 售后相关；6= 网站相关；7= 其它方面
 *  @param  6	POST	是	content	   String 	  投诉内容
 *  @param  7	POST	否	images	 String	 图片的url
 */
-(void)request_Order_addComplaintsParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.63 取消订单 (Order.cancelOrder)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.cancelOrder	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	order_id	 Int	 订单ID
 */
-(void)request_Order_cancelOrderParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.64 订单中可申请退货的商品 (Order.goodsOrder)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.cancelOrder	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	order_id	 Int	 订单ID
 */
-(void)request_Order_goodsOrderParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.65 单个商品立即支付 (Buycart.done)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Buycart.done	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	goods_id	 Int	 商品id
 *  @param  5	GET	    是	number	  Int	购买数量
 *  @param  6	POST	是	spec	   String 	  商品属性 例:143979,143981
 *  @param  7	POST	是	address_id	 Int	 收货地址id
 *  @param  8	POST	是	extend_shipping	 Int	 快递id
 *  @param  9	GET	    是	payment_id	  Int	支付类型 1 => 余额支付
 *  @param  10	POST	否	m_pay_type	   String 	  支付代码(暂无)
 *  @param  11	POST	否	p_password	 String	 支付密码(32位MD5)
 *  @param  12	POST	否	bonus	 Int	 红包id
 */
-(void)request_Buycart_doneParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.66 退货订单详情 (Order.returnDetail)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.returnDetail	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	ret_id	 Int	 退货订单id
 *  @param  5	POST	    是	order_id	  Int	订单id
 */
-(void)request_Order_returnDetailParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.67 添加寄回退货信息 (Order.ReturnAddressNew)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.ReturnAddressNew	  string	接口调用api名称
 *  @param  2	POST	是	user_id	   Int 	  会员id
 *  @param  3	POST	是	sessionkey	 Int	 sessionkey
 *  @param  4	POST	是	ret_id	 Int	 退货订单id
 *  @param  5	POST	是	other_express	  String	快递名称
 *  @param  6	POST	是	express_sn	  Int	快递单号
 */
-(void)request_Order_returnAddressParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.68 专柜特区 (Category.cateGoriesList)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Category.cateGoriesList	  string	接口调用api名称
 *  @param  2	POST	是	cat_id	   Int 	  商品分类id
 */
-(void)request_Category_cateGoriesListParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.69 退换货注意事项 (Order.returnContent)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.returnContent	  string	接口调用api名称
 */
-(void)request_Order_returnContentParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.70 选择支付种类 (Order.orderPay)
 *
 *  @param 序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Order.returnContent	  string	接口调用api名称
 */
//3.70 选择支付种类 (Order.orderPay)
-(void)request_Order_orderPayParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.71 签到人数 Index.signNum
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	Index.signNum	string	接口调用api名称
 */
-(void)request_Index_signNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.72 急验验证请求地址 (GeeTest.geeTestUrl)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	是	GeeTest.geeTestUrl	string	接口调用api名称
 */
-(void)request_GeeTest_geeTestUrlWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.73 手机号码是否注册(User.checkPhone)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.checkPhone	string	接口调用api名称
 *  @param  2	POST	是	mobile_phone	string	手机号码
 */
-(void)request_User_checkPhoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.74 获取支持的银行(Bank.cardList)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Bank.cardList	string	接口调用api名称
 *  @param  2	POST	是	mobile_phone	string	手机号码
 */
-(void)request_Bank_cardListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.75 推荐奖励(UserRecommend.index)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRecommend.index	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 */
-(void)request_UserRecommend_indexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.76 积分转红金宝(UserRecommend.integral)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRecommend.index	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	user_money	string	要转积分数量
 *  @param  5	POST	是	pay_password	string	支付密码(MD5)
 */
-(void)request_UserRecommend_integralWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
*  3.77 积分转红金宝(UserRecommend.integralMoney)
*
*  @param  序号	请求方式	必填	名称	类型	描述
*  @param  1	GET	    是	UserRecommend.integralMoney	 string	接口调用api名称
*  @param  2	POST	是	user_id	 string	会员id
*  @param  3	POST	是	sessionkey	string	sessionkey
*  @param  4	POST	是	user_money	string	要转积分数量
*  @param  5	POST	是	pay_password	string	支付密码(MD5)
*/
-(void)request_UserRecommend_integralMoneyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.78 订单列表（白拿）(GoodsOrder.OrderList)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	GoodsOrder.OrderList	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	page_now	int		第几页
 *  @param  5	POST	是	page_size	int	数量
  *  @param  6	POST	否	order_type	int	类型1->白拿0->普通订单
  *  @param  7	POST	是	order_status	string		订单类型0 =>所有 2 => 待付款 3 =>待发货 4 => 待收货 5 => 待评论 6=> 带返还
 */
-(void)GoodsOrder_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.79 立即购买选择页面（白拿）(FreeFlow.FreeCheckout)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	FreeFlow.FreeCheckout	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	goods_id	int			商品id
 *  @param  5	POST	是	goods_spec	string	商品属性
 *  @param  6	POST	否	address_id	int	收货地址id
 *  @param  7	POST	是	packagess_id	int		套餐id
 *  @param  8	POST	是	shipping_id	 int		快递id
 */
-(void)FreeFlow_FreeCheckoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  3.80 白拿支付（白拿）(FreeFlow.FreeDone)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	FreeFlow.FreeDone	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	goods_id	int			商品id
 *  @param  5	POST	是	goods_spec	string	商品属性
 *  @param  6	POST	否	address_id	int	收货地址id
 *  @param  7	POST	是	packagess_id	int		套餐id
 *  @param  8	POST	是	shipping_id	 int		快递id
 *  @param  9	POST	是	pay_id	int		支付方式id
 *  @param  10	POST	是	pay_password	 string		支付密码md5
 */
-(void)FreeFlow_FreeDoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  3.81 白拿订单取消白拿（白拿）(GoodsOrder.AdvanceGet)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	GoodsOrder.AdvanceGet	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	order_id	int		订单id
 */
-(void)GoodsOrder_AdvanceGetWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;




#pragma mark --- version 3.50 接口 
//****************************************************************************************************************************************************
/**
 *    version 3.50 接口 (来源：http://tsiteapi.3658mall.com/Public/suppdemo/)
 */


/**
 *   #1
 */

/**
 *   #2
 */

/**
 *   #3
 */

/**
 *   #4 订单列表(weiyb) (GoodsOrder.OrderList)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	GoodsOrder.OrderList	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	page_now	int		第几页
 *  @param  5	POST	是	page_size	int		数量
 *  @param  6	POST	否	order_type	int		类型1->白拿0->普通订单
 *  @param  7	POST	是	order_status	int		订单类型0 =>所有 2 => 待付款 3 =>待发货 4 => 待收货 5 => 待评论 6=> 带返还
 */

- (void)request_GoodsOrder_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #6 获取白拿规则(weiyb) (Line.GetFreeRules)
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Line.GetFreeRules	 string	接口调用api名称
 *
 *  @param  2	POST	是	sessionkey	string	sessionkey
 *  @param  3   POST    是  order_amt  float 商品价格
 *
 */
-(void)request_Line_GetFreeRulesWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #8 获取订单(yanh) Line.GetOrders
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Line.GetOrders	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	status	int		订单状态,默认为空，返还中1已返还2
 *  @param  5	POST	是	start	int		开始条数
 *  @param  6	POST	否	num	int		每页显示条数
 *  @param  7	POST	是	type	int		订单类型：0普通订单1白拿订单
 */
- (void)request_Line_GetOrdersWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *   #10 提交订单(yanh) Line.LineOrder
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Line.LineOrder	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	order_amt	float		价格
 *  @param  5	POST	是	rule_id	int		白拿的id
 *  @param  6	POST	否	pay_password		支付密码
 *  @param  7	POST	否	suppliers_id	商家的id
 *  @param  8	POST	是	pay_type_id     支付方式id
 *  @param  9	POST	否	erweima_id	二维码id

 */
-(void)request_line_lineOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *    #13 接口：Scan.GetFree
 *
 *  @param  1	GET	    是	Scan.GetFree	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *
 */
-(void)request_Scan_GetFreeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *    #14 接口：Scan.ScanCodeStart
 *
 *  @param  1	GET	    是	Scan.ScanCodeStart	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  3	POST	是	erweima_id	string	二维码ID
 *
 */
-(void)request_Scan_ScanCodeStartWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #15 二维码扫描(yanh) Scan.SelectFreeCode
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Scan.SelectFreeCode	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST    是  erweima_id   string 商家id
 *  @param  5   POST    否  user_money   string  金额
 */
-(void)request_Scan_SelectFreeCodeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;




/**
 *   #16 获取订单详情(yanh) Line.GetOrder
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Line.GetOrder	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	order_id	int		订单id
 */
- (void)request_Line_GetOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *   #17 提前取消白拿订单(yanh) Line.OverOrder
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Line.OverOrder	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	order_id	int		订单id
 */
- (void)request_Line_OverOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #18 慧赚宝首页(weiyb) UserHzb.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.Index	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 */
- (void)request_UserHzb_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #19 转入慧赚宝(weiyb) UserHzb.HzbIn
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.HzbIn	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	act_money	string	转入金额
 *  @param  5	POST	是	p_password	string	支付密码
 */
- (void)request_UserHzb_HzbInWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *   #20 慧赚宝明细(weiyb) UserHzb.HzbDesc
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.HzbDesc	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	hzb_day	int	详情类型 0累计收益1昨天收益7周收益30月收益
 */
- (void)request_UserHzb_HzbDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *   #21 慧赚宝转入转出明细(weiyb) UserHzb.HzbMoneyDesc
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.HzbDesc	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	hzb_type	int	0全部1转入2转出
 */
- (void)request_UserHzb_HzbMoneyDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #20 转出慧赚宝(weiyb) UserHzb.HzbOut
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.HzbOut	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	act_money	string	转出金额
 *  @param  5	POST	是	p_password	string	支付密码
 */
- (void)request_UserHzb_HzbOutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

#pragma mark --- version 商户端特有接口
/**
 *    version 商户端特有接口 接口 (来源：http://tsiteapi.3658mall.com/Public/suppdemo/)
 */


/**
 *    #1 商家首页接口：UserSupp.Index
 *
 *  @param  1	GET	    是	UserSupp.Index	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *
 */
-(void)request_UserSupp_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *    #2 商家资金明细接口：UserSupp.MoneyDesc
 *
 *  @param  1	GET	    是	UserSupp.MoneyDesc	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  3	POST	否	type	int		0全部1线上2线下3提现4红金宝明细
 *  @param  3	POST	否	page_now	int	第几页
 *  @param  3	POST	否	page_size	int	每页数量
 *
 */
-(void)request_UserSupp_MoneyDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #18  提交提现(sentangle)
 *
 *  @param  1	GET	    是	SuppTakecash.Take	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST    是   number      string   最小：0	提现金额
 *  @param  5	POST    否   money_type   int    范围：money/points	提现货币类型，money-余额，points-红金宝
 *  @param  6	POST    是   pay_passwd  string  支付密码
 *
 *  @return
 */
-(void)request_SuppTakecash_TakeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *    #19 提现信息(sentangle)
 *
 *  @param  1	GET	    是	SuppTakecash.TakeInfo	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *
 */
-(void)request_SuppTakecash_TakeInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *    #127 购物车商品数量修改(weiyb)  Upflow.SetgoodsNum
 *
 *  @param  1	GET	    是	Upflow.SetgoodsNum	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	goods_number	 int	数量
 *  @param  5	POST	是	rec_id	int	 购物车接口返回参数rec_id
 */
-(void)request_Upflow_SetgoodsNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #146 会员交易大厅委托记录(weiyb) UserJY.Order
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJY.Order	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	type	int	类型1=>买入2=>卖出
 *  @param  5	POST	否	page_now	int	最小：1	第几页
 *  @param  6   POST    否  page_size  int   最小：1	数量
 */
-(void)request_UserJY_OrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *    #147 设置交易密码(weiyb)  UserJY.SetTransPasswd
 *
 *  @param  1	GET	    是	UserJY.SetTransPasswd	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	trans_passwd	 string	交易密码(MD5)
 *  @param  5	POST	是	p_passwd	string	登录密码（MD5）
 *  @param  6	POST	是	code	string	手机验证码
 */
-(void)request_UserJY_SetTransPasswdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #148 会员交易大厅成交记录(weiyb) 接口：UserJY.Userorder
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJY.Userorder	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	type	int	类型1=>买入2=>卖出
 *  @param  5	POST	否	page_now	int	最小：1	第几页
 *  @param  6   POST    否  page_size  int   最小：1	数量
 */
-(void)request_UserJY_UserorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *   #150 取消委托(weiyb) 接口：UserJY.Stop
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJY.Stop	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	否	id		int	 id
 */
-(void)request_UserJY_StopWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #149 交易大厅 HJB 买入卖出(weiyb) 接口：UserJY.Add
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJY.Add	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 *  @param  4	POST	是	price	int	价格
 *  @param  5	POST	是	point_num	int	数量
 *  @param  6   POST    是  trans_passwd  string   支付密码
 *  @param  7   POST    是  trans_type  string   操作类型1=>买入2卖出
 */
-(void)request_UserJY_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *   #150 会员交易大厅个人中心(weiyb) 接口：UserJY.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJY.Add	 string	接口调用api名称
 *  @param  2	POST	是	user_id	 string	会员id
 *  @param  3	POST	是	sessionkey	string	sessionkey
 */
-(void)request_UserJY_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #151 交易大厅首页(weiyb) 接口：JY.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	JY.Index	 string	接口调用api名称
 *  @param  2	POST	是	user_id	     string	会员id
 *  @param  3	POST	是	sessionkey	 string	sessionkey
 */
-(void)request_JY_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #152 交易大厅首页记录(weiyb) 接口：JY.Order
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	JY.Order	 string	接口调用api名称
 *  @param  2	POST	是	user_id	     string	会员id
 *  @param  3	POST	是	sessionkey	 string	sessionkey
 *  @param  4	POST	否	type	     int	类型1=>买入2卖出
 *  @param  5   POST    否  page_now     int    第几页
 *  @param  6   POST    否  page_size    int    数量
 */
-(void)request_JY_OrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *   #153 是否设置交易密码(weiyb) UserJY.Issetpsd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	JY.Order	 string	接口调用api名称
 *  @param  2	POST	是	user_id	     string	会员id
 *  @param  3	POST	是	sessionkey	 string	sessionkey
 */
-(void)request_UserJY_IssetpsdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #154 是否设置交易密码(weiyb) UserJY.Issetpsd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Category.Newcatlist	string	接口调用api名称
 *  @param  2	POST	是	cat_id	    int	0=>所有1级分类,其他是各自分类
 */
-(void)request_Category_NewcatlistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #16 开户支行地区关键字(weiyb) Bank.BankSearch
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Bank.BankSearch	接口调用api名称
 *  @param  2	POST	是	user_id	    string 用户id
 *  @param  3	POST	是	sessionkey	string 用户sessionKey
 *  @param  4	POST	是	bank_name	string	银行名称 例:华夏银行
 *  @param  5	POST	是	p_name	    string  省份名称 例:山东
 *  @param  2	POST	是	c_name	    string  城市名 称例:临沂
 *  @param  2	POST	是	d_name	    string  地区名称 例:兰山区
 *  @param  2	POST	是	keyWorder	    string  关键字
 */
-(void)request_Bank_BankSearchWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #155 是否登陆接口(weiyb) Bank.Relogin
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Bank.Relogin	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 */
-(void)request_Bank_ReloginWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #156 文章分享列表(weiyb) Share.Lists
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Share.Lists	  string	接口调用api名称
 *  @param  2	POST	否	user_id	      string    用户ID
 *  @param  3	POST	否	page_now	  int       第几页
 *  @param  4	POST	否	page_size	  int       数量
 */
-(void)request_Share_ListsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #157 签到完成(weiyb) SignNew.CompleteSign
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	SignNew.CompleteSign	  string	接口调用api名称
 *  @param  2	POST	否	user_id	      string    用户ID
 *  @param  3	POST	是	sessionkey	  string    用户sessionKey
 */
-(void)request_SignNew_CompleteSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;



/**
 *  #158 短提示获取(weiyb) GetCom.Index
 *
 *  @param  序号  请求方式  必填  名称  类型  描述
 *  @param  1  GET      是  GetCom.Index    string  接口调用api名称
 *  @param  2  POST  否  id        string    1=>手续费 2=>提现说明 例 可以传单一id 也可以传多个id多个id请用,隔开
 */
-(void)request_GetCom_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #159 红金宝转余额前置条件(weiyb) UserJYM.Check
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJYM.Check string	接口调用api名称
 *  @param  2	POST	否	user_id	      string    用户ID
 *  @param  3	POST	是	sessionkey	  string    用户sessionKey
 */
-(void)request_UserJYM_CheckWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #160 红金宝转余额(weiyb) UserJYM.JymSub
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserJYM.JymSub string	接口调用api名称
 *  @param  2	POST	否	user_id	      string    用户ID
 *  @param  3	POST	是	sessionkey	  string    用户sessionKey
 *  @param  4	POST	是	money	      int       数量
 */
-(void)request_UserJYM_JymSubWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #161 完成分享(weiyb) DayShare.CompleteShare
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	DayShare.CompleteShare string	接口调用api名称
 *  @param  2	POST	是	user_id	      string    用户ID
 *  @param  3	POST	是	sessionkey	  string    用户sessionKey
 */
-(void)request_DayShare_CompleteShareWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #162 每日分享链接(weiyb) DayShare.Lists
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	DayShare.Lists string	接口调用api名称
 */
-(void)request_DayShare_ListsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #163 体验金列表(PPOGG) UserHzb.TyjList
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserHzb.TyjList     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  2	POST	是	page_now	        int     第几页
 *  @param  3	POST	是	page_size	        int     每页数量
 */
-(void)request_UserHzb_TyjListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #164 商品购物车数量(PPOGG) Flow.CartAllNum
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Flow.CartAllNum     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 */
-(void)request_Flow_CartAllNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

//********************************************************************************
//********************************************************************************
#pragma mark - Version 4.0 聊天接口
/**
 *  #159  Rongyun.Gettaken
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Rongyun.Gettaken	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 */
-(void)request_Rongyun_GettakenWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #160 获取好友列表(ppogg) UserRongyun.Friendslist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Friendslist	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	page_now	    第几页（此处始终定为第一页）
 *  @param  5	POST	是	page_size	    数量 （上传 9999）
 */
-(void)request_UserRongyun_FriendslistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #161 搜索好友(ppogg) UserRongyun.Searchfriends
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Searchfriends	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	user_name	    好友名称/手机号码
 */
-(void)request_UserRongyun_SearchfriendsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #162 添加好友(ppogg) UserRongyun.Friendsadd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Searchfriends	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 *  @param  5	POST	否	desc	    	申请好友描述
 */
-(void)request_UserRongyun_FriendsaddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #163 好友请求处理(ppogg) UserRongyun.FriendsaddUP
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.FriendsaddUP	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 *  @param  5	POST	否	state	    	0=>未处理1=同意2=>拒绝3=>删除此信息
 */
-(void)request_UserRongyun_FriendsaddUPWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #164 删除好友(ppogg) UserRongyun.FriendsDel
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.FriendsDel	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 */
-(void)request_UserRongyun_FriendsDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #165 黑名单列表(ppogg) UserRongyun.Frindsblacklist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Frindsblacklist	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	page_now	    	第几页(	最小：1)
 *  @param  5	POST	是	page_size	    	数量(	最小：1)
 */
-(void)request_UserRongyun_FrindsblacklistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #166  加入黑名单(ppogg) UserRongyun.FrindsblacklistAdd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.FrindsblacklistAdd	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 */
-(void)request_UserRongyun_FrindsblacklistAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #167  移出黑名单(ppogg) UserRongyun.FrindsblacklistDel
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.FrindsblacklistDel	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 */
-(void)request_UserRongyun_FrindsblacklistDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #168  好友关系请求记录(ppogg) UserRongyun.Frindssavelists
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Frindssavelists	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	page_now	    	第几页(	最小：1)
 *  @param  5	POST	是	page_size	    	数量(	最小：1)
 */
-(void)request_UserRongyun_FrindssavelistsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #169  会员信息(ppogg) UserRongyun.UserInfo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.UserInfo	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id
 */
-(void)request_UserRongyun_UserInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #170  获取群列表(ppogg) UserRongyun.Grouplist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Grouplist	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	page_now	    	第几页(	最小：1)
 *  @param  5	POST	是	page_size	    	数量(	最小：1)
 */
-(void)request_UserRongyun_GrouplistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #171  搜索群(ppogg) UserRongyun.Searchgroup
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.Searchgroup	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_name	    	群名称/群ID
 */
-(void)request_UserRongyun_SearchgroupWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #172  群详情(ppogg) UserRongyun.GroupDesc
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupDesc	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_id	    	群ID
 *  @param  5	POST	是	page_now	    	第几页(	最小：1)
 *  @param  6	POST	是	page_size	    	数量(	最小：1)
 */
-(void)request_UserRongyun_GroupDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #173  创建群(ppogg) UserRongyun.GroupCreate
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupCreate	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	会员id(多个用,隔开)
 *  @param  5	POST	是	group_name	    		群名称
 *  @param  6	POST	是	content	    	群详情
 */
-(void)request_UserRongyun_GroupCreateWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #174  退出群(ppogg)、剔出群成员(群主功能)  UserRongyun.GroupBack
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupBack	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	f_user_id	    	群主剔出成员ID(群主功能)
 *  @param  5	POST	是	group_id	    		群ID
 */
-(void)request_UserRongyun_GroupBackWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #175  解散群(ppogg)  UserRongyun.GroupDel
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupDel	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_id	    		群ID
 */
-(void)request_UserRongyun_GroupDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #176  会员加群(ppogg)  UserRongyun.GroupAdd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupAdd	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_id	    		群ID
 */
-(void)request_UserRongyun_GroupAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #177  群主邀请入群(ppogg)  UserRongyun.GroupBossAddUser
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupBossAddUser	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_id	    		群ID
 *  @param  5	POST	是	f_user_id	    	会员id(多个用,隔开)
 */
-(void)request_UserRongyun_GroupBossAddUserWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #178  群主修改群信息(ppogg)  UserRongyun.GroupBossUp
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupBossUp	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	upFile	    		群头像
 *  @param  5	POST	是	group_name	    	群名
 *  @param  6	POST	是	contents	    	群介绍
 */
-(void)request_UserRongyun_GroupBossUpWithParams:(NSDictionary *)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #179  群主同意入群(ppogg) UserRongyun.GroupBossAdd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.GroupBossAdd	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 *  @param  4	POST	是	group_id	    	群ID
 *  @param  5	POST	是	f_user_id	    		成员ID
 *  @param  6	POST	是	state	    		1=同意2=>拒绝
 */
-(void)request_UserRongyun_GroupBossAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #179  聊天室列表(ppogg) UserRongyun.ChatroomList
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.ChatroomList	string	接口调用api名称
 *  @param  2	POST	是	user_id	    用户ID
 *  @param  3	POST	是	sessionkey	    用户sessionKey
 */
-(void)request_UserRongyun_ChatroomListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #180  关联手机通讯录(ppogg) UserRongyun.RelationTel
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserRongyun.RelationTel	string	接口调用api名称
 *  @param  2	POST	是	user_id	   string  用户ID
 *  @param  3	POST	是	sessionkey	 string   用户sessionKey
 *  @param  4	POST	否	tel	  string  手机号码 , 多个手机号码请用,隔开
 */
-(void)request_UserRongyun_RelationTelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
#pragma mark-------------------生活缴费-------------
/**
 *  #176 生活缴费订单(PPOGG) Elife.Elifelist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifelist     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	start               int     0=>全部1待支付2=>待返还
 *  @param  5	POST	否	page_now	        int     第几页
 *  @param  6	POST	否	page_size	        int     数量
 */
-(void)request_Elife_ElifelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #177 缴费订单删除(PPOGG) Elife.DelElife
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.DelElife    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	elife_id	        int  	订单ID
 */
-(void)request_Elife_DelElifeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #178 生活缴费地址获取(PPOGG) Elife.Elifechange
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifechange     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	province_id	        string  	省份ID此参数为获取下级城市返回格式也不同!!!!!
 */
-(void)request_Elife_ElifechangeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #179 获取缴费类型(PPOGG) Elife.ElifechangeTC
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.ElifechangeTC     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	province_id	        string  	省份ID
 *  @param  5	POST	否	city_id	        string  	市ID
 */
-(void)request_Elife_ElifechangeTCWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #180 获取缴费单位(PPOGG) Elife.Elifechangecompany
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifechangecompany     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	province_id	        string  	省份ID
 *  @param  5	POST	否	recharge_type	        string  	缴费类型ID
 *  @param  6	POST	否	city_id	        string  	市ID
 */
-(void)request_Elife_ElifechangecompanyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #181 获取商品信息(PPOGG) Elife.Elifechangeinfo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifechangeinfo     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	province_id	        string  	省份ID
 *  @param  5	POST	否	recharge_type	        string  	缴费类型ID
 *  @param  6	POST	否	city_id	        string  	市ID
 *  @param  7	POST	否	corpid	        string  	缴费单位ID
 */
-(void)request_Elife_ElifechangeinfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #182 验证帐号(PPOGG) Elife.Elifecheckuser
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifecheckuser     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	provname	        string  	省份名
 *  @param  5	POST	否	cityname	        string  	城市名
 *  @param  6	POST	否	corpid	        string  	缴费单位ID
 *  @param  7	POST	否	corpname	        string  	缴费单位名
 *  @param  8	POST	否	recharge_type	        string  	缴费类型ID(水电煤的类型ID)
 *  @param  9	POST	否	cardid	        string  	产品产品信息ID(elifechangeinfo接口返回ProductId)
 *  @param  10	POST	否	account	        string  	账号
 
 */
-(void)request_Elife_ElifecheckuserWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #183 话费充值白拿白赚提前取出(PPOGG) ElifeRecharge.CancelRecharge
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.CancelRecharge     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 */
-(void)request_ElifeRecharge_CancelRechargeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #184 话费充值白拿白赚提前取出(PPOGG)ElifeRecharge.Delrecharge
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.Delrecharge     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 */
-(void)request_ElifeRecharge_DelrechargeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #185 话费充值订单(PPOGG) ElifeRecharge.Rechargelist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifelist     string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	start               int     0=>全部1待支付2=>待返还
 *  @param  5	POST	否	page_now	        int     第几页
 *  @param  6	POST	否	page_size	        int     数量
 */
-(void)request_ElifeRecharge_RechargelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #186 生活缴费水电煤确认付款(PPOGG) Elife.DoElife
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.DoElife    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	否	provname	        string  	省份名
 *  @param  5	POST	否	cityname	        string  	城市名
 *  @param  6	POST	否	corpid	        string  	缴费单位ID
 *  @param  7	POST	否	corpname	        string  	缴费单位名
 *  @param  8	POST	否	recharge_type	        string  	缴费类型ID(水电煤的类型ID)
 *  @param  9	POST	否	product_info	        string  	产品产品信息ID(elifechangeinfo接口返回ProductId)
 *  @param  10	POST	否	productname	        string  	产品信息名称
 *  @param  11	POST	否	province	        string  	省份ID(elifechange接口返回的ProvinceId)
 *  @param  12	POST	否	cityid	        string  	城市ID(elifechange接口返回的CityId)
 *  @param  13	POST	否	typename	        string  	缴费类型名称(水电煤的PayProjectName)
 *  @param  14	POST	否	fee	        string  	缴费金额
 *  @param  15	POST	否	account	        string  	缴费账号
 *  @param  16	POST	否	recharge_way	        string  	户号
 *  @param  17	POST	否	contractid	        string  	欠费账单
 *  @param  18	POST	否	PrePaidFlag	        string  	elifecheckuser接口返回PrePaidFlag的值
 *  @param  19	POST	否	package	        string  	白拿套餐id
 *  @param  20	POST	否	pay_id	        string  	支付方式ID
 *  @param  21	POST	否	smscode	        string  	短信验证码
 *  @param  22	POST	否	account_name	        string  	elifecheckuser返回参数户主姓名
 
 */
-(void)request_Elife_DoElifeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #187 生活和缴费套餐选择(PPOGG) Elife.ElifeConfirm
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.DoElife    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	fee	            整型  缴费金额
 *  @param  5	POST	是	PrePaidFlag	            string  elifecheckuser接口返回PrePaidFlag的值
 */
-(void)request_Elife_ElifeConfirmWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #188 话费订单详情(PPOGG) ElifeRecharge.RechargeInfo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.RechargeInfo    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 */
-(void)request_ElifeRecharge_RechargeInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #189 手机话费充值套餐选择(PPOGG) ElifeRecharge.Changetaocan
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.Changetaocan    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 
 */
-(void)request_ElifeRecharge_ChangetaocanWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #190 话费充值(PPOGG) ElifeRecharge.RechargeDo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.RechargeDo    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	price	        string  金额
 *  @param  5	POST	是	package	        string  套餐id
 *  @param  6	POST	是	phone	        string  手机号
 *  @param  7	POST	是	m_pay_type	        string  支付方式1=>余额2=>支付宝3=>微信
 *  @param  8	POST	是	code	        string  短信验证码
 *  @param  8	POST	是	pay_password	        string  支付密码(MD5)
 */
-(void)request_ElifeRecharge_RechargeDoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #191 话费充值续费(PPOGG) ElifeRecharge.RechargeXufei
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.RechargeXufei    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 */
-(void)request_ElifeRecharge_RechargeXufeiWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #192 获取手机号码归属地(cais) ElifeRecharge.GetPhoneAttribution
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.GetPhoneAttribution    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	tel	        字符串  	电话号码
 */
-(void)request_ElifeRecharge_GetPhoneAttributionWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #193 话费充值余额付款(PPOGG) ElifeRecharge.Elifeorderdo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.Elifeorderdo    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 *  @param  4	POST	否	pay_password	    string  	支付密码(MD5)
 */
-(void)request_ElifeRecharge_ElifeorderdoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #194 生活缴费余额付款(PPOGG) Elife.Elifeorderdo
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Elife.Elifeorderdo    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4	POST	是	recharge_id	        int  	订单ID
 *  @param  4	POST	否	pay_password	    string  	支付密码(MD5)
 */
-(void)request_Elife_ElifeorderdoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #195 首页商品热卖、热评、新品(fjw) Index.HeatGoods
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Index.HeatGoods    string	接口调用api名称
 *  @param  2	POST	是	limit	            string  4
 
 */
-(void)request_Index_HeatGoodsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #196 首页商品热卖、热评、新品列表(fjw) Index.HeatGoodsList
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Index.HeatGoodsList    string	接口调用api名称
 *  @param  2	POST	是	limit	            string  6
 *  @param  3	POST	是	page	            string  1
 *  @param  4	POST	是	type	            string  	1热卖2热评3新品
 */
-(void)request_Index_HeatGoodsListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #197 任务中心任务列表(PPOGG) TaskConter.TaskConterIndex
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.Cleartel    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 */
-(void)request_TaskConter_TaskConterIndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #198 任务中心领取任务(PPOGG) TaskConter.GetTask
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	ElifeRecharge.Cleartel    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4   POST    是  task_id	整型	必须			任务ID
 */
-(void)request_TaskConter_GetTaskWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #199 任务中心领取奖励(PPOGG) TaskConter.GetMoney
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.GetMoney    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4   POST    是  task_id	整型	必须			任务ID
 */
-(void)request_TaskConter_GetMoneyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #200 任务中心会员中心转余额(PPOGG) TaskConter.ZhuanYue
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.ZhuanYue    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4   POST    是  number	整型	必须			金额数量
 */
-(void)request_TaskConter_ZhuanYueWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #201 进度条领取奖励(PPOGG) TaskConter.JindutiaoJiangli
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.JindutiaoJiangli    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4   POST    是  now_jindu	整型	必须			当前活跃值
 */
-(void)request_TaskConter_JindutiaoJiangliWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #202 任务完成(PPOGG) TaskConter.TaskWancheng
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.TaskWancheng    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  4   POST    是  order_id 	整型	必须			任务ID
 */
-(void)request_TaskConter_TaskWanchengWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #203 第一次注册登录APP弹窗(PPOGG) TaskConter.NewLogin
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.NewLogin    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 */
-(void)request_TaskConter_NewLoginWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #204 手动结束白拿订单(PPOGG)  GoodsOrder.OrderFinish
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	GoodsOrder.OrderFinish    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 *  @param  3	POST	是	order_id	        string  订单id
 */
-(void)request_GoodsOrder_OrderFinishWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #144 领取注册红包(PPOGG) User.Zhucehongbao
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	GoodsOrder.OrderFinish    string	接口调用api名称
 *  @param  2	POST	是	user_id	            string  用户ID
 *  @param  3	POST	是	sessionkey	        string  用户sessionKey
 */
-(void)request_ZhucehongbaoWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block;
/**
 *  #163 第三方登录注册(weiyb) User.OpenRegister
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.OpenRegister string	接口调用api名称
 *  @param  2	POST	是	mobile_phone	  string    手机号码
 *  @param  3	POST	是	passwd	          string    密码MD5
 *  @param  4	POST	是	m_code	          string    短信验证码
 *  @param  5	POST	否	open_type	      int       1=>QQ 2=>微信 3=>微博
 *  @param  6	POST	否	open_key	      string    open_id(第三方返回唯一KEY)
 */
-(void)request_User_OpenRegisterWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #164 第三方登录绑定(weiyb) UserOpen.Band
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserOpen.Band     string	接口调用api名称
 *  @param  2	POST	是	user_id	  string    用户ID
 *  @param  3	POST	是	sessionkey	          string    用户sessionKey
 *  @param  4	POST	是	open_type	      int       1=>QQ 2=>微信 3=>微博
 *  @param  5	POST	是	open_key	      string    open_id(第三方返回唯一KEY)
 *  @param  6	POST	是	passwd	          string    密码MD5
 *  @param  7	POST	是	m_code	          string    短信验证码
 */
-(void)request_UserOpen_BanddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #165 第三方绑定(weiyb) User.OpenBand
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.OpenBand     string	接口调用api名称
 *  @param  2	POST	是	mobile_phone	  string    手机号码
 *  @param  3	POST	是	passwd	          string    密码MD5
 *  @param  4	POST	是	m_code	          string    短信验证码
 *  @param  5	POST	否	open_type	      int       1=>QQ 2=>微信 3=>微博
 *  @param  6	POST	否	open_key	      string    open_id(第三方返回唯一KEY)
 */
-(void)request_User_OpenBandWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #166 第三方帐号解绑(weiyb) UserOpen.BandDel
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.OpenBand     string	接口调用api名称
 *  @param  2	POST	是	user_id	  string    用户ID
 *  @param  3	POST	是	sessionkey	          string    用户sessionKey
 *  @param  4	POST	是	open_type	      int       1=>QQ 2=>微信 3=>微博
 *  @param  6	POST	是	passwd	          string    密码MD5
 *  @param  7	POST	是	m_code	          string    短信验证码
 */
-(void)request_UserOpen_BandDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #167 查看第三方帐号绑定状态(weiyb) UserOpen.Index
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.OpenBand     string	接口调用api名称
 *  @param  2	POST	是	user_id	  string    用户ID
 *  @param  3	POST	是	sessionkey	          string    用户sessionKey
 */
-(void)request_UserOpen_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

//********************************************************************************
//********************************************************************************
#pragma mark - Version 慧赚宝App1.0
/**
 *  #168 获取经营类目信息（zhangh） Suppliers.GetCategory
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Suppliers.GetCategory     string	接口调用api名称
 */
-(void)request_Suppliers_GetCategoryWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #169 上传图片 UserCenter.UploadImage
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	UserCenter.UploadImage     string	接口调用api名称
 *  @param  2	POST	是	user_id	  string    用户ID
 *  @param  3	POST	是	sessionkey	          string    用户sessionKey
 *  @param  4	POST	是	pic	          file    	最大：3698688 范围：image/jpeg/image/gif/image/png
 */
-(void)request_UserCenter_UploadImageWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #170 认证信息提交(zhangh) SuppTakecash.SupAuth
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	SuppTakecash.SupAuth string	   接口调用api名称
 *  @param  2	POST	是	user_id	  	         string    用户ID
 *  @param  3	POST	是	sessionkey	         string    用户sessionKey
 *  @param  3	POST	是	sup_name	         string    商家名称
 *  @param  3	POST	是	business_cate	     string    经营范围
 *  @param  3	POST	是	sup_pic	             string    店铺门店照片
 *  @param  3	POST	是	business_license	 string    营业执照
 *  @param  3	POST	是	card_back	         string    手持身份证
 */
-(void)request_SuppTakecash_SupAuthWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #171 验证是否是商家账户（zhangh） User.CheckSup
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User.CheckSup     string	接口调用api名称
 *  @param  2	POST	是	user_id	  string    用户ID
 *  @param  3	POST	是	sessionkey	          string    用户sessionKey
 */
-(void)request_User_CheckSupWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #172 获取订单(zhangh) FanXian.OrderList
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	FanXian.OrderList       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	否	suppliers_id	        string    商家ID
 *  @param  5	POST	否	status	                string    订单状态,默认为全部，0 : 未开始 1 ：进行中 2：已结束 3：全部（默认3）
 *  @param  6	POST	否	page	                string    页码（默认1）
 *  @param  7	POST	否	num	                    string    每页显示条数（默认10）
 *  @param  8	POST	是	type	                string    订单类型：1普通返现订单 2超级返现订单 3全部（默认3）
 */
-(void)request_FanXian_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #173 加速返现(zhangh) FanXian.AddSupOrder
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	FanXian.OrderList       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	是	order_list_id	        string    订单id(最小1)
 *  @param  5	POST	是	act_money	            string    保证金金额（最小10）
 *  @param  6	POST	是	pay_password	        string    支付密码
 */
-(void)request_FanXian_AddSupOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #174 保证金转出(zhangh) FanXian.GetSupMoney
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	FanXian.OrderList       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	是	order_list_id	        string    订单id(最小1)
 *  @param  5	POST	是	pay_password	        string    支付密码
 */
-(void)request_FanXian_GetSupMoneyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #175 新签到（zhangh) SignNew.NewSign
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	SignNew.NewSign       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 */
-(void)request_SignNew_NewSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #176 请求添加银行卡（zhangh) XianFeng.Add
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	XianFeng.Add       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param 4	POST	是	bank_type	int	银行的类型,参考表bank_code
 *  @param 5	POST	是	card_code	string	卡号
 *  @param 6	POST	是	mobile	string	银行预留手机号
 *  @param 7	POST	否	bank_address	string	"银行区域，-分割 格式：山东-临沂市-兰山区-银雀山路50号"
 *  @param 8	POST	是	type_type	string	C =信用卡  D =借记卡
 @param 9	POST	否	card_exp	string	银行卡有效期 如果有效期是11/12，则填写格式为1112
 @param 10	POST	否	card_cvv2	string	校验码是信用卡背面的4位数字
 @param 11	POST	否	name	 string	姓名(实名认证)11/12，则填写格式为1112
 @param 12	POST	否	card_number	 string	身份证号码(实名认证)
 */
-(void)request_XianFeng_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #177 确认添加银行卡(zhangh) XianFeng.Add_bank_code
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	XianFeng.Add_bank_code       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param 4	POST	是	fid 	int
 *  @param 5	POST	是	sms_code	string	验证码
 */
-(void)request_XianFeng_Add_bank_codeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #178 先锋再次获取短信验证码(zhangh) XianFeng.Sms_code
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	XianFeng.Add_bank_code       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param 4	POST	是	fid 	int
 */
-(void)request_XianFeng_Sms_codeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #179 摇钱树(zhangh) User_YxUrl
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	User_YxUrl       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 */
-(void)request_User_YxUrlWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #180共享红包展示页面 Loophappy.Rulelist
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Rulelist       string	  接口调用api名称
 */
-(void)request_Loophappy_RulelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #181 打开共享红包 Loophappy.Openred
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Openred       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	order_id	            string    订单ID
 */
-(void)request_Loophappy_OpenredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #182 检验购买资格 Loophappy.Checkgetred
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Openred       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	rule_id	            string    红包ID
 */
-(void)request_Loophappy_CheckgetredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #183 购买共享红包 Loophappy.Getred
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Getred      string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	rule_id	            string    红包ID
 *  @param  3	POST	是	coupons_id	            string    奖励券ID
 *  @param  3	POST	是	pwd	            string    支付密码
 *  @param  3	POST	是	pay_id	            string    支付方式 1余额,2支付宝
 */
-(void)request_Loophappy_GetredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #184 我的共享列表 Loophappy.Myred
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Myred       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  2	POST	是	page	                string    页数
 *  @param  2	POST	是	num	                string    数量
 *  @param  2	POST	是	type	                string    1进行中,2已结束
 */
-(void)request_Loophappy_MyredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #185 我的共享详情页 Loophappy.Myreddetail
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Loophappy.Myreddetail       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	order_id	            string    订单id
 */
-(void)request_Loophappy_MyreddetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #186 生成确认支付页面接口(weiyb)   HzbShoping.DirectBtBy
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	HzbShoping.DirectBtBy       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	是	goods_id	            string    商品id
 *  @param  5	POST	是	goods_spec	            string    商品属性
 *  @param  6	POST	是	address_id	            string    收货地址id
 *  @param  7	POST	是	sessionshipping_idkey	            string    快递id
 *  @param  8	POST	是	num	            string    购买数量
 */
-(void)request_HzbShoping_DirectBtByWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #187 衣食住行删除订单 Lifefree.Delorder
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Lifefree.Delorder       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	order_id	            string    订单id
 */
-(void)request_Lifefree_DelorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #188 共享额度订单列表 Lifefree.Orderlist
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Lifefree.Orderlist      string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	page	            string    页码
 *  @param  3	POST	是	num	            string    每页显示数量
 */
-(void)request_Lifefree_OrderlistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #189 列表页更多订单链接 Lifefree.Moreorders
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Lifefree.Moreorders      string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 */
-(void)request_Lifefree_MoreordersWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;
/**
 *  #190 结束订单 Lifefree.Endorder
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Lifefree.Endorder      string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	order_id	            string    订单id
 */
-(void)request_Lifefree_EndorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #191    立即购买生成订单   HzbShoping.orderdone
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	HzbShoping.orderdone       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	是	goods_id	            string    商品id
 *  @param  5	POST	是	goods_spec	            string    商品属性
 *  @param  6	POST	是	address_id	            string    收货地址id
 *  @param  7	POST	是	shipping_id	            string    快递id
 *  @param  8	POST	是	num	            string    购买数量
 *  @param  9	POST	是	coupon_id	            string    使用抵用券ID
 *  @param  10	POST	是	sharing_type	            string    抵用类型 3不抵用1共享额度抵用
 *  @param  11	POST	是	pay_id	            string    支付方式
 *  @param  12	POST	是	content	            string    买家备注留言
 */
-(void)request_HzbShoping_orderdoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;

/**
 *  #192    平台内资金支付   HzbShoping.Orderpay
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	HzbShoping.orderdone       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 *  @param  4	POST	是	pay_pwd	            string        支付密码
 *  @param  5	POST	是	order_sn	            string    订单编号
 */
-(void)request_HzbShoping_OrderpayWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


/**
 *  #193    购物车商品(多个或者一个)提交   HzbShoping.Checkout
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	HzbShoping.orderdone       string	  接口调用api名称
 *  @param  2	POST	是	user_id	                string    用户ID
 *  @param  3	POST	是	sessionkey	            string    用户sessionKey
 */
-(void)request_HzbShoping_CheckoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block;


@end
