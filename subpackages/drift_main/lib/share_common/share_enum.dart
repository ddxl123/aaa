
enum RegisterOrLoginType {
  
  email_send,

  email_verify,

  phone_send,

  phone_verify,

}
        
enum KnowledgeBaseContentSortType {
  
  by_random("随机"),
  by_hot("最高热度"),
  by_create_time("最近创建"),
  by_publish_time("最近发布"),
  by_update_time("最近修改"),
  by_like_count("最多喜欢"),
  by_save_count("最多保存");
                
  const KnowledgeBaseContentSortType(this.text);
  final String text;
}
        
enum SyncCurdType {
  
  c,

  u,

  d,

}
        
enum StudyStatus {
  
  never,

  review,

  complete,

  stop,

}
        
enum NewDisplayOrder {
  
  random,

  title_a_2_z,

  create_early_2_late,

}
        
enum NewReviewDisplayOrder {
  
  mix,

  new_review,

  review_new,

}
        
enum ReviewDisplayOrder {
  
  expire_first,

  no_expire_first,

  ignore_expire,

}
        
enum Gender {
  
  male("男"),
  female("女");
                
  const Gender(this.text);
  final String text;
}
        