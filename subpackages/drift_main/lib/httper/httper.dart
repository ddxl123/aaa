
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


part 'dto_vo_bo/dto_vo/DataUploadDto.dart';


part 'dto_vo_bo/dto_vo/DataUploadVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupTagNewFragmentGroupTagDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupTagNewFragmentGroupTagVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupCountQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupCountQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupModifyDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupModifyVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupOneSubQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupOneSubQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentInsertFragmentDto.dart';


part 'dto_vo_bo/dto_vo/FragmentInsertFragmentVo.dart';


part 'dto_vo_bo/dto_vo/FragmentModifyFragmentDto.dart';


part 'dto_vo_bo/dto_vo/FragmentModifyFragmentVo.dart';


part 'dto_vo_bo/dto_vo/FragmentQueryFragmentGroupWithRDto.dart';


part 'dto_vo_bo/dto_vo/FragmentQueryFragmentGroupWithRVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryVo.dart';


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


part 'dto_vo_bo/dto_vo/SingleRowDeleteDto.dart';


part 'dto_vo_bo/dto_vo/SingleRowDeleteVo.dart';


part 'dto_vo_bo/dto_vo/SingleRowInsertDto.dart';


part 'dto_vo_bo/dto_vo/SingleRowInsertVo.dart';


part 'dto_vo_bo/dto_vo/SingleRowModifyDto.dart';


part 'dto_vo_bo/dto_vo/SingleRowModifyVo.dart';


part 'dto_vo_bo/dto_vo/SingleRowQueryDto.dart';


part 'dto_vo_bo/dto_vo/SingleRowQueryVo.dart';


