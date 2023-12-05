
library httper;

import 'dart:convert';
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


part 'dto_vo_bo/dto_vo/BeFollowQueryDto.dart';


part 'dto_vo_bo/dto_vo/BeFollowQueryVo.dart';


part 'dto_vo_bo/dto_vo/FollowAndBeFollowedCountQueryDto.dart';


part 'dto_vo_bo/dto_vo/FollowAndBeFollowedCountQueryVo.dart';


part 'dto_vo_bo/dto_vo/FollowOrBeFollowedListQueryDto.dart';


part 'dto_vo_bo/dto_vo/FollowOrBeFollowedListQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupAllSubFragmentGroupsQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupAllSubFragmentGroupsQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupAllSubFragmentsCountQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupAllSubFragmentsCountQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupInformationDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupInformationVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupLikeChangeForCurrentLoginedDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupLikeChangeForCurrentLoginedVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupModifyDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupModifyVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupOneSubQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupOneSubQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsDeleteDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsDeleteVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsFragmentIdsWithRQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsFragmentIdsWithRQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsFragmentsCountQueryDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsFragmentsCountQueryVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsMoveDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsMoveVo.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsReuseDto.dart';


part 'dto_vo_bo/dto_vo/FragmentGroupsReuseVo.dart';


part 'dto_vo_bo/dto_vo/FragmentInsertFragmentDto.dart';


part 'dto_vo_bo/dto_vo/FragmentInsertFragmentVo.dart';


part 'dto_vo_bo/dto_vo/FragmentModifyFragmentDto.dart';


part 'dto_vo_bo/dto_vo/FragmentModifyFragmentVo.dart';


part 'dto_vo_bo/dto_vo/FragmentQueryFragmentGroupWithRDto.dart';


part 'dto_vo_bo/dto_vo/FragmentQueryFragmentGroupWithRVo.dart';


part 'dto_vo_bo/dto_vo/FragmentsDeleteDto.dart';


part 'dto_vo_bo/dto_vo/FragmentsDeleteVo.dart';


part 'dto_vo_bo/dto_vo/FragmentsMoveDto.dart';


part 'dto_vo_bo/dto_vo/FragmentsMoveVo.dart';


part 'dto_vo_bo/dto_vo/FragmentsReuseDto.dart';


part 'dto_vo_bo/dto_vo/FragmentsReuseVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryModifyVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseCategoryQueryVo.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryDto.dart';


part 'dto_vo_bo/dto_vo/KnowledgeBaseFragmentGroupQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentIdsQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentIdsQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentsCountQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentsCountQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentsQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupFragmentsQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupManyUpdateDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupManyUpdateVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupMemoryInfoDownloadDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupMemoryInfoDownloadVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupMemoryInfoDownloadByInfoIdsDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupMemoryInfoDownloadByInfoIdsVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupPageFirstQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupPageFirstQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupPageOtherQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupPageOtherQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupSelectedFragmentsInsertDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupSelectedFragmentsInsertVo.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupsQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryGroupsQueryVo.dart';


part 'dto_vo_bo/dto_vo/MemoryInfoDownloadOnlyIdDto.dart';


part 'dto_vo_bo/dto_vo/MemoryInfoDownloadOnlyIdVo.dart';


part 'dto_vo_bo/dto_vo/MemoryInfoUploadSyncDto.dart';


part 'dto_vo_bo/dto_vo/MemoryInfoUploadSyncVo.dart';


part 'dto_vo_bo/dto_vo/MemoryModelManyUpdateDto.dart';


part 'dto_vo_bo/dto_vo/MemoryModelManyUpdateVo.dart';


part 'dto_vo_bo/dto_vo/MemoryModelsQueryDto.dart';


part 'dto_vo_bo/dto_vo/MemoryModelsQueryVo.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForPublishPageDto.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForPublishPageVo.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForUserInfoDto.dart';


part 'dto_vo_bo/dto_vo/PersonalHomePageForUserInfoVo.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByFragmentGroupIdDto.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByFragmentGroupIdVo.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByLikeDto.dart';


part 'dto_vo_bo/dto_vo/QueryFragmentGroupTagByLikeVo.dart';


part 'dto_vo_bo/dto_vo/ShorthandsQueryDto.dart';


part 'dto_vo_bo/dto_vo/ShorthandsQueryVo.dart';


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


