enum RegisterOrLoginType {
  email_send,
  email_verify,
  phone_send,
  phone_verify,
}

enum KnowledgeBaseContentSortType {
  by_random(text: ""),
  by_hot(text: ""),
  by_create_time(text: ""),
  by_publish_time(text: ""),
  by_update_time(text: ""),
  by_like_count(text: ""),
  by_save_count(text: "");

  const KnowledgeBaseContentSortType({required this.text});

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

enum AlgorithmUsageStatus {
  a,
  b,
  c,
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
