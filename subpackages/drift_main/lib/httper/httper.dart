
library httper;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../share_common/http_file_enum.dart';

part 'BaseObject.dart';

part 'httper_init.dart';

part 'HttpPath.dart';

part 'httper.g.dart';

part 'OtherResponseCode.dart';

part 'HttperException.dart';

part 'dto_vo_bo/bo/bo.dart';

part 'dto_vo_bo/dto_vo/CheckLoginDto.dart';


part 'dto_vo_bo/dto_vo/CheckLoginVo.dart';


part 'dto_vo_bo/dto_vo/LogoutDto.dart';


part 'dto_vo_bo/dto_vo/LogoutVo.dart';


part 'dto_vo_bo/dto_vo/SendOrVerifyDto.dart';


part 'dto_vo_bo/dto_vo/SendOrVerifyVo.dart';


part 'dto_vo_bo/dto_vo/DataDownloadForFragmentGroupDto.dart';


part 'dto_vo_bo/dto_vo/DataDownloadForFragmentGroupVo.dart';


part 'dto_vo_bo/dto_vo/DataDownloadForKnowledgeBaseDto.dart';


part 'dto_vo_bo/dto_vo/DataDownloadForKnowledgeBaseVo.dart';


part 'dto_vo_bo/dto_vo/DataUploadDto.dart';


part 'dto_vo_bo/dto_vo/DataUploadVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupTagNewFragmentGroupTagDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupTagNewFragmentGroupTagVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupInnerQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupInnerQueryVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryVo.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForFragmentPageDto.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForFragmentPageVo.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForPublishPageDto.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForPublishPageVo.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForUserInfoDto.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForUserInfoVo.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByFragmentGroupIdDto.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByFragmentGroupIdVo.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByLikeDto.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByLikeVo.dart';


part 'dto_vo_bo/dto_vo/SingleFieldModifyDto.dart';


part 'dto_vo_bo/dto_vo/SingleFieldModifyVo.dart';


part 'dto_vo_bo/dto_vo/SingleRowQueryDto.dart';


part 'dto_vo_bo/dto_vo/SingleRowQueryVo.dart';


