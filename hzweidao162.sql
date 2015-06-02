/*
 Navicat MySQL Data Transfer

 Source Server         : 123.57.14.162
 Source Server Version : 50173
 Source Host           : 123.57.14.162
 Source Database       : hzweidao

 Target Server Version : 50173
 File Encoding         : utf-8

 Date: 06/01/2015 20:53:20 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `comment_info`
-- ----------------------------
DROP TABLE IF EXISTS `comment_info`;
CREATE TABLE `comment_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lcomment_evel` int(10) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `order_code` varchar(255) DEFAULT NULL,
  `comment_desc` longtext,
  `product_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user` varchar(255) DEFAULT NULL,
  `more1` varchar(255) DEFAULT NULL,
  `more2` varchar(255) DEFAULT NULL,
  `more3` varchar(255) DEFAULT NULL,
  `is_show` tinyint(4) DEFAULT NULL COMMENT '是否显示',
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `comp_order_info`
-- ----------------------------
DROP TABLE IF EXISTS `comp_order_info`;
CREATE TABLE `comp_order_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cus_name` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `comp_name` varchar(255) DEFAULT NULL,
  `comp_id` int(11) DEFAULT NULL,
  `content` text,
  `status` tinyint(4) DEFAULT NULL,
  `audit_status` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `gift_exchange_log`
-- ----------------------------
DROP TABLE IF EXISTS `gift_exchange_log`;
CREATE TABLE `gift_exchange_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exchange_no` varchar(45) DEFAULT NULL COMMENT '兑换编号',
  `gift_type` varchar(45) DEFAULT NULL COMMENT '礼券类型',
  `gift_value` int(11) DEFAULT NULL COMMENT '礼券值',
  `exchange_status` tinyint(4) DEFAULT NULL COMMENT '兑换状态',
  `exchange_desc` varchar(45) DEFAULT NULL COMMENT '兑换描述',
  `cus_id` int(11) DEFAULT NULL COMMENT '兑换用户ID',
  `cus_mobile` varchar(45) DEFAULT NULL COMMENT '手机号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '兑换时间',
  `create_user` varchar(45) DEFAULT NULL COMMENT '兑换者',
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL COMMENT '交易number',
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `gift_info`
-- ----------------------------
DROP TABLE IF EXISTS `gift_info`;
CREATE TABLE `gift_info` (
  `id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `gift_name` varchar(255) DEFAULT NULL COMMENT '礼券名称',
  `gift_password` varchar(255) DEFAULT NULL COMMENT '礼券密码',
  `gift_no` varchar(50) DEFAULT NULL COMMENT '礼券编号',
  `gift_type` varchar(50) DEFAULT NULL COMMENT '礼券类型',
  `gift_image` varchar(255) DEFAULT NULL COMMENT '礼券图片',
  `gift_desc` longtext COMMENT '礼券描述',
  `gift_order` int(10) DEFAULT NULL COMMENT '礼券排序',
  `gift_start_time` timestamp NULL DEFAULT NULL COMMENT '礼券开始时间',
  `gift_end_time` timestamp NULL DEFAULT NULL COMMENT '礼券有效时间',
  `gift_value` int(10) DEFAULT NULL COMMENT '礼券值',
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(50) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(50) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'no_exchange',
  `audit_status` varchar(45) DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `gift_price` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_advertise`
-- ----------------------------
DROP TABLE IF EXISTS `lh_advertise`;
CREATE TABLE `lh_advertise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adv_name` varchar(255) DEFAULT NULL,
  `adv_body` varchar(45) DEFAULT NULL,
  `adv_link_address` varchar(255) DEFAULT NULL,
  `advref_id` int(11) DEFAULT NULL,
  `adv_type` varchar(100) DEFAULT '0',
  `area_id` int(11) DEFAULT NULL,
  `adv_desc` varchar(255) DEFAULT NULL,
  `adv_img` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_advertise_place`
-- ----------------------------
DROP TABLE IF EXISTS `lh_advertise_place`;
CREATE TABLE `lh_advertise_place` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_title` varchar(255) DEFAULT NULL,
  `area_code` varchar(45) DEFAULT NULL,
  `area_status` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `area_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_buy_log`
-- ----------------------------
DROP TABLE IF EXISTS `lh_buy_log`;
CREATE TABLE `lh_buy_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `lh_com_info`
-- ----------------------------
DROP TABLE IF EXISTS `lh_com_info`;
CREATE TABLE `lh_com_info` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公司ID',
  `comp_name` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `comp_logo` varchar(255) DEFAULT NULL COMMENT '公司logo',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司基本信息';

-- ----------------------------
--  Table structure for `lh_com_user`
-- ----------------------------
DROP TABLE IF EXISTS `lh_com_user`;
CREATE TABLE `lh_com_user` (
  `comp_use_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comp_id` int(11) NOT NULL COMMENT '公司ID',
  `username` varchar(100) DEFAULT NULL COMMENT 'username',
  `email` varchar(100) DEFAULT NULL COMMENT 'email',
  `mobile_phone_number` varchar(20) DEFAULT NULL COMMENT 'mobile_phone_number',
  `password` varchar(100) DEFAULT NULL COMMENT 'password',
  `salt` varchar(10) DEFAULT NULL COMMENT 'salt',
  `status` varchar(50) DEFAULT NULL COMMENT 'status',
  `admin` tinyint(1) DEFAULT NULL COMMENT 'admin',
  `deleted` tinyint(1) DEFAULT NULL COMMENT 'deleted',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`comp_use_id`),
  UNIQUE KEY `unique_sys_user_email` (`email`),
  UNIQUE KEY `unique_sys_user_mobile_phone_number` (`mobile_phone_number`),
  UNIQUE KEY `unique_sys_user_username` (`username`),
  KEY `idx_sys_user_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='子账号用户表';

-- ----------------------------
--  Table structure for `lh_comp_job`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_job`;
CREATE TABLE `lh_comp_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comp_id` int(11) NOT NULL COMMENT '公司ID',
  `name` varchar(100) DEFAULT NULL COMMENT 'name',
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'parent_id',
  `parent_ids` varchar(200) DEFAULT NULL COMMENT 'parent_ids',
  `icon` varchar(200) DEFAULT NULL COMMENT 'icon',
  `weight` int(11) DEFAULT NULL COMMENT 'weight',
  `is_show` tinyint(1) DEFAULT NULL COMMENT 'is_show',
  PRIMARY KEY (`id`),
  KEY `idx_sys_job_nam` (`name`) USING BTREE,
  KEY `idx_sys_job_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_sys_job_parent_ids_weight` (`parent_ids`,`weight`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职务';

-- ----------------------------
--  Table structure for `lh_comp_org`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_org`;
CREATE TABLE `lh_comp_org` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comp_id` int(11) NOT NULL COMMENT '公司ID',
  `name` varchar(100) DEFAULT NULL COMMENT 'name',
  `type` varchar(20) DEFAULT NULL COMMENT 'type',
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'parent_id',
  `parent_ids` varchar(200) DEFAULT NULL COMMENT 'parent_ids',
  `icon` varchar(200) DEFAULT NULL COMMENT 'icon',
  `weight` int(11) DEFAULT NULL COMMENT 'weight',
  `is_show` tinyint(1) DEFAULT NULL COMMENT 'is_show',
  PRIMARY KEY (`id`),
  KEY `idx_sys_organization_name` (`name`) USING BTREE,
  KEY `idx_sys_organization_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_sys_organization_parent_ids_weight` (`parent_ids`,`weight`) USING BTREE,
  KEY `idx_sys_organization_type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
--  Table structure for `lh_comp_permission`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_permission`;
CREATE TABLE `lh_comp_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT 'name',
  `permission` varchar(100) DEFAULT NULL COMMENT 'permission',
  `description` varchar(200) DEFAULT NULL COMMENT 'description',
  `is_show` tinyint(1) DEFAULT NULL COMMENT 'is_show',
  PRIMARY KEY (`id`),
  KEY `idx_sys_permission_name` (`name`) USING BTREE,
  KEY `idx_sys_permission_permission` (`permission`) USING BTREE,
  KEY `idx_sys_permission_show` (`is_show`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
--  Table structure for `lh_comp_resource`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_resource`;
CREATE TABLE `lh_comp_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT 'name',
  `identity` varchar(100) DEFAULT NULL COMMENT 'identity',
  `url` varchar(200) DEFAULT NULL COMMENT 'url',
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'parent_id',
  `parent_ids` varchar(200) DEFAULT NULL COMMENT 'parent_ids',
  `icon` varchar(200) DEFAULT NULL COMMENT 'icon',
  `weight` int(11) DEFAULT NULL COMMENT 'weight',
  `is_show` tinyint(1) DEFAULT NULL COMMENT 'is_show',
  PRIMARY KEY (`id`),
  KEY `idx_sys_resource_identity` (`identity`) USING BTREE,
  KEY `idx_sys_resource_name` (`name`) USING BTREE,
  KEY `idx_sys_resource_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_sys_resource_parent_ids_weight` (`parent_ids`,`weight`) USING BTREE,
  KEY `idx_sys_resource_user` (`url`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
--  Table structure for `lh_comp_role`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_role`;
CREATE TABLE `lh_comp_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comp_id` int(11) NOT NULL COMMENT '公司ID',
  `name` varchar(100) DEFAULT NULL COMMENT 'name',
  `role` varchar(100) DEFAULT NULL COMMENT 'role',
  `description` varchar(200) DEFAULT NULL COMMENT 'description',
  `is_show` tinyint(1) DEFAULT NULL COMMENT 'is_show',
  PRIMARY KEY (`id`),
  KEY `idx_sys_role_name` (`name`) USING BTREE,
  KEY `idx_sys_role_role` (`role`) USING BTREE,
  KEY `idx_sys_role_show` (`is_show`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
--  Table structure for `lh_comp_role_res_per`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_role_res_per`;
CREATE TABLE `lh_comp_role_res_per` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint(20) DEFAULT NULL COMMENT 'role_id',
  `resource_id` bigint(20) DEFAULT NULL COMMENT 'resource_id',
  `permission_ids` varchar(500) DEFAULT NULL COMMENT 'permission_ids',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_sys_role_resource_permission` (`role_id`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源权限关联';

-- ----------------------------
--  Table structure for `lh_comp_user_auth`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_user_auth`;
CREATE TABLE `lh_comp_user_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `org_id` bigint(20) DEFAULT NULL COMMENT 'organization_id',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'job_id',
  `comp_user_id` int(11) DEFAULT NULL COMMENT 'user_id',
  `role_ids` varchar(500) DEFAULT NULL COMMENT 'role_ids',
  `type` varchar(50) DEFAULT NULL COMMENT 'type',
  PRIMARY KEY (`id`),
  KEY `idx_sys_auth_job` (`job_id`) USING BTREE,
  KEY `idx_sys_auth_organization` (`org_id`) USING BTREE,
  KEY `idx_sys_auth_type` (`type`) USING BTREE,
  KEY `idx_sys_auth_user` (`comp_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户授权';

-- ----------------------------
--  Table structure for `lh_comp_user_org_job`
-- ----------------------------
DROP TABLE IF EXISTS `lh_comp_user_org_job`;
CREATE TABLE `lh_comp_user_org_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comp_use_id` bigint(20) DEFAULT NULL COMMENT 'user_id',
  `organization_id` bigint(20) DEFAULT NULL COMMENT 'organization_id',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'job_id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_sys_user_organization_job` (`comp_use_id`,`organization_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织职务';

-- ----------------------------
--  Table structure for `lh_cus_contacter`
-- ----------------------------
DROP TABLE IF EXISTS `lh_cus_contacter`;
CREATE TABLE `lh_cus_contacter` (
  `con_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(4) DEFAULT NULL COMMENT '0=man 1=woman',
  `job` varchar(20) DEFAULT NULL COMMENT '职位',
  `tel` varchar(13) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`con_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户联系人';

-- ----------------------------
--  Table structure for `lh_cus_info`
-- ----------------------------
DROP TABLE IF EXISTS `lh_cus_info`;
CREATE TABLE `lh_cus_info` (
  `cus_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `company_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `company_user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `code` varchar(30) DEFAULT NULL COMMENT '客户编号',
  `name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `type` varchar(20) DEFAULT NULL COMMENT '客户类型',
  `user_name` varchar(30) DEFAULT NULL COMMENT '客户账号',
  `state` varchar(20) DEFAULT NULL COMMENT '所在省',
  `city` varchar(20) DEFAULT NULL COMMENT '所在市',
  `district` varchar(20) DEFAULT NULL COMMENT '所在区县',
  `address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `tel` varchar(13) DEFAULT NULL COMMENT '联系电话',
  `fax` varchar(13) DEFAULT NULL COMMENT '传真',
  `email` varchar(30) DEFAULT NULL COMMENT 'E-MAIL',
  `default_receiver_id` int(11) DEFAULT NULL COMMENT '默认收货地址',
  `sale_use_name` int(11) DEFAULT NULL COMMENT '销售人员ID',
  `zip` varchar(6) DEFAULT NULL COMMENT '邮编',
  `company_header` varchar(50) DEFAULT NULL COMMENT '公司负责人',
  `buy_header` varchar(50) DEFAULT NULL COMMENT '采购负责人',
  `designer` varchar(50) DEFAULT NULL COMMENT '主要设计师',
  `product_demand` varchar(50) DEFAULT NULL COMMENT '产品需求',
  `invoice_type` varchar(30) DEFAULT NULL COMMENT 'no=无发票 common=普通 added=增值',
  `invoice_title` varchar(100) DEFAULT NULL COMMENT '发票抬头',
  `invoice_content` varchar(255) DEFAULT NULL COMMENT '发票明细',
  `invoice_bank_name` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `invoice_bank_account` varchar(50) DEFAULT NULL COMMENT '开户账号',
  `invoice_tel` varchar(50) DEFAULT NULL COMMENT '开户电话',
  `invoice_tax_no` varchar(50) DEFAULT NULL COMMENT '纳税人识别号',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  `password` varchar(255) DEFAULT NULL,
  `mobile` varchar(45) NOT NULL,
  `balance` double(255,2) DEFAULT '0.00',
  `integration` int(11) DEFAULT '0',
  `is_freeze` int(2) DEFAULT '0' COMMENT '冻结状态 0：未冻结 1：冻结',
  PRIMARY KEY (`cus_id`),
  UNIQUE KEY `mobile_UNIQUE` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='客户信息';

-- ----------------------------
--  Table structure for `lh_cus_receiver`
-- ----------------------------
DROP TABLE IF EXISTS `lh_cus_receiver`;
CREATE TABLE `lh_cus_receiver` (
  `receiver_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `name` varchar(30) DEFAULT NULL COMMENT '收货人',
  `mobile` varchar(11) DEFAULT NULL COMMENT '收货人手机',
  `tel` varchar(13) DEFAULT NULL COMMENT '收货人电话',
  `state` varchar(20) DEFAULT NULL COMMENT '收货人省',
  `city` varchar(20) DEFAULT NULL COMMENT '收货人市',
  `district` varchar(20) DEFAULT NULL COMMENT '收货人区',
  `address` varchar(100) DEFAULT NULL COMMENT '收货详细地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`receiver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='客户收货地址';

-- ----------------------------
--  Table structure for `lh_cus_visit_record`
-- ----------------------------
DROP TABLE IF EXISTS `lh_cus_visit_record`;
CREATE TABLE `lh_cus_visit_record` (
  `vis_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `cus_name` varchar(30) DEFAULT NULL COMMENT '客户名称',
  `appointment` varchar(30) DEFAULT NULL COMMENT '预约对象',
  `tel` varchar(13) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机',
  `appoint_start_time` datetime DEFAULT NULL COMMENT '预约开始时间',
  `appoint_end_time` datetime DEFAULT NULL COMMENT '预约结束时间',
  `place` varchar(50) DEFAULT NULL COMMENT '地点',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `real_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `real_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  `visit_content` varchar(1000) DEFAULT NULL COMMENT '拜访记录',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`vis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户拜访记录';

-- ----------------------------
--  Table structure for `lh_fn_info`
-- ----------------------------
DROP TABLE IF EXISTS `lh_fn_info`;
CREATE TABLE `lh_fn_info` (
  `fn_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `campany_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `fn_no` varchar(30) DEFAULT NULL COMMENT '单号',
  `fn_type` varchar(20) DEFAULT NULL COMMENT 'order=订单 refund=退单 advance=预付款\r\n(buy=采购 buy_refund=采购退款 buy_advance=预付款\r\nsale=销售 sale_refund=销售退款 sale_advance=预收款)',
  `fn_time` datetime DEFAULT NULL COMMENT '收付款日期',
  `fn_amount` int(11) DEFAULT NULL COMMENT '收付款金额',
  `relate_id` int(11) DEFAULT NULL COMMENT '关联客户',
  `fn_user_name` varchar(30) DEFAULT NULL COMMENT '经办人',
  `fn_mode` varchar(20) DEFAULT NULL COMMENT '收付款方式',
  `bill_amount` int(11) DEFAULT NULL COMMENT '业务金额',
  `amount` int(11) DEFAULT NULL COMMENT '确定金额',
  `foreign_amount` varchar(30) DEFAULT NULL COMMENT '外币金额',
  `exchange_rate` varchar(20) DEFAULT NULL COMMENT '汇率',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` varchar(20) DEFAULT NULL COMMENT 'un=未审核 audit=审核 pass=确认',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '0=未删除\r\n1=删除',
  `fn_flag` tinyint(4) DEFAULT NULL COMMENT '0=收款\r\n1=付款',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` varchar(20) DEFAULT NULL COMMENT '审核者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`fn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收付款单';

-- ----------------------------
--  Table structure for `lh_fn_info_record`
-- ----------------------------
DROP TABLE IF EXISTS `lh_fn_info_record`;
CREATE TABLE `lh_fn_info_record` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `fid` int(11) DEFAULT NULL COMMENT '主单ID',
  `bid` int(11) DEFAULT NULL COMMENT '核销单据ID',
  `bill_code` varchar(30) DEFAULT NULL COMMENT '核销单据code',
  `bill_type` varchar(30) DEFAULT NULL COMMENT 'order=订单 refund=退单 advance=预付款',
  `bill_amount` int(11) DEFAULT NULL COMMENT '业务金额',
  `amount` int(11) DEFAULT NULL COMMENT '确定金额',
  `pass_flag` tinyint(4) DEFAULT '0' COMMENT '0=未核销\r\n1=核销',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收付款单据信息';

-- ----------------------------
--  Table structure for `lh_lsc_check`
-- ----------------------------
DROP TABLE IF EXISTS `lh_lsc_check`;
CREATE TABLE `lh_lsc_check` (
  `check_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `campany_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `stock_no` varchar(20) DEFAULT NULL COMMENT '入库单号',
  `ware_id` int(11) NOT NULL COMMENT '仓库ID',
  `stock_time` datetime DEFAULT NULL COMMENT '入出库日期',
  `stock_user_id` int(11) DEFAULT NULL COMMENT '操作人',
  `actual_amount` int(11) DEFAULT NULL COMMENT '实际入库',
  `plan_amount` int(11) DEFAULT NULL COMMENT '计划入库',
  `change_amount` int(11) DEFAULT NULL COMMENT '当前入库',
  `remark` varchar(200) DEFAULT NULL COMMENT 'in=入库 out=出库 stock=盘点修正',
  `audit_info` varchar(200) DEFAULT NULL COMMENT '审核信息',
  `status` varchar(20) NOT NULL COMMENT 'un=未确认\r\nok=已确认\r\nno=取消',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` varchar(20) NOT NULL COMMENT '创建账号',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新账号',
  `mobile` varchar(45) DEFAULT NULL COMMENT '推荐人联系方式',
  PRIMARY KEY (`check_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='盘点记录';

-- ----------------------------
--  Table structure for `lh_lsc_check_record`
-- ----------------------------
DROP TABLE IF EXISTS `lh_lsc_check_record`;
CREATE TABLE `lh_lsc_check_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `check_id` int(11) DEFAULT NULL COMMENT '盘点Id',
  `product_id` int(11) DEFAULT NULL COMMENT '产品Id',
  `cate_id` int(11) DEFAULT NULL COMMENT '产品类型ID',
  `suk_id` int(11) DEFAULT NULL COMMENT '商品规格ID',
  `suk_code` varchar(30) DEFAULT NULL COMMENT '商品货号',
  `sup_suk_code` varchar(30) DEFAULT NULL COMMENT '商品货号',
  `suk_value` varchar(255) DEFAULT NULL COMMENT '产品规格属性值',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_unit` varchar(10) DEFAULT NULL COMMENT '产品单位',
  `product_attrs` varchar(1000) DEFAULT NULL COMMENT '产品属性',
  `product_note` varchar(1000) DEFAULT NULL COMMENT '产品备注',
  `actual_amount` int(11) DEFAULT NULL COMMENT '实际入库',
  `plan_amount` int(11) DEFAULT NULL COMMENT '计划入库',
  `change_amount` int(11) DEFAULT NULL COMMENT '当前入库',
  `remark` varchar(200) DEFAULT NULL COMMENT 'in=入库 out=出库 stock=盘点修正',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` varchar(20) NOT NULL COMMENT '创建账号',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新账号',
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='盘点明细记录';

-- ----------------------------
--  Table structure for `lh_lsc_stock`
-- ----------------------------
DROP TABLE IF EXISTS `lh_lsc_stock`;
CREATE TABLE `lh_lsc_stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `campany_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `stock_no` varchar(20) DEFAULT NULL COMMENT '入库单号',
  `stock_type` varchar(20) NOT NULL COMMENT 'buy=采购进货 sale=销售订单 buy_refund=采购退货 sale_refund=销售退货 check=盘点',
  `ware_id` int(11) DEFAULT NULL COMMENT '仓库ID',
  `relate_type` varchar(255) DEFAULT NULL COMMENT 'order=订单 refund=退单',
  `relate_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `in_out_flag` tinyint(4) DEFAULT NULL COMMENT '入库单：0 出库单：1',
  `stock_time` datetime DEFAULT NULL COMMENT '入出库日期',
  `stock_user_name` varchar(20) DEFAULT NULL COMMENT '操作人',
  `referrer` varchar(20) DEFAULT NULL COMMENT '推荐人',
  `shop_id` int(11) DEFAULT NULL COMMENT '商家名称',
  `shop_name` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '商家联系人',
  `customer_phone` varchar(20) DEFAULT NULL COMMENT '商家联系电话',
  `card_num` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `transport_num` varchar(20) DEFAULT NULL COMMENT '运输公司运单号',
  `transport_name` varchar(50) DEFAULT NULL COMMENT '运输公司名称',
  `transport_price` int(11) DEFAULT NULL COMMENT '快递费用',
  `address` varchar(1000) DEFAULT NULL COMMENT '送货地址',
  `send_time` datetime DEFAULT NULL COMMENT '发货时间',
  `pre_arrive_time` datetime DEFAULT NULL COMMENT '预计到达的时间',
  `plan_package` int(11) DEFAULT NULL COMMENT '预计数',
  `total_package` int(11) DEFAULT NULL COMMENT '总件数',
  `remark` varchar(200) DEFAULT NULL COMMENT 'in=入库 out=出库 stock=盘点修正',
  `audit_info` varchar(200) DEFAULT NULL COMMENT '审核信息',
  `status` varchar(20) NOT NULL COMMENT 'un=未确认\r\nok=已确认\r\nno=取消',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` varchar(20) NOT NULL COMMENT '创建账号',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新账号',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8 COMMENT='库存';

-- ----------------------------
--  Table structure for `lh_lsc_stock_record`
-- ----------------------------
DROP TABLE IF EXISTS `lh_lsc_stock_record`;
CREATE TABLE `lh_lsc_stock_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `stock_id` int(11) NOT NULL COMMENT '库存单ID',
  `sup_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `stock_no` varchar(20) DEFAULT NULL COMMENT '入库单号',
  `ware_id` int(11) DEFAULT NULL COMMENT '仓库ID',
  `in_out_flag` varchar(20) DEFAULT NULL COMMENT '入库单：STOCK_IN 出库单：STOCK_OUT',
  `product_id` int(11) DEFAULT NULL COMMENT '产品ID',
  `sku_id` int(11) DEFAULT NULL COMMENT '规格ID',
  `sup_sku_code` varchar(20) DEFAULT NULL COMMENT '供应商货号',
  `sku_code` varchar(20) DEFAULT NULL COMMENT '商品唯一码',
  `cylinder_no` varchar(100) DEFAULT NULL COMMENT '缸号',
  `batch_no` varchar(100) DEFAULT NULL COMMENT '批号',
  `sku_value` varchar(200) DEFAULT NULL COMMENT '产品规格属性',
  `product_name` varchar(200) DEFAULT NULL COMMENT '产品名称',
  `sku_price` decimal(10,2) DEFAULT NULL COMMENT '产品规格价格',
  `attr_str` varchar(2000) DEFAULT NULL COMMENT '产品属性',
  `actual_amount` int(11) DEFAULT NULL COMMENT '实际入库',
  `plan_amount` int(11) DEFAULT NULL COMMENT '计划入库',
  `stock_amount` int(11) DEFAULT NULL COMMENT '当前入库',
  `product_unit` varchar(20) DEFAULT NULL COMMENT '产品单位',
  `stock_status` varchar(20) NOT NULL COMMENT 'NORMAL-正常 SCRAP-报废\r\n',
  `audite_status` varchar(20) NOT NULL COMMENT 'un=未审核\r\nok=审核通过\r\nno=审核失败',
  `remark` varchar(200) DEFAULT NULL COMMENT 'in=入库 out=出库 stock=盘点修正',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建账号',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新账号',
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COMMENT='入出库明细';

-- ----------------------------
--  Table structure for `lh_lsc_ware`
-- ----------------------------
DROP TABLE IF EXISTS `lh_lsc_ware`;
CREATE TABLE `lh_lsc_ware` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `campany_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `ware_name` varchar(20) DEFAULT NULL COMMENT '仓库名称',
  `ware_code` varchar(20) DEFAULT NULL COMMENT '仓库编码',
  `ware_type` varchar(20) DEFAULT NULL COMMENT '仓库类型',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `contact` varchar(100) DEFAULT NULL COMMENT '收货人姓名',
  `zip_code` varchar(10) DEFAULT NULL COMMENT '邮编',
  `telephone` varchar(100) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='仓库设置';

-- ----------------------------
--  Table structure for `lh_ord_order`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_order`;
CREATE TABLE `lh_ord_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_code` varchar(30) DEFAULT NULL COMMENT '订单编号',
  `order_from` varchar(100) DEFAULT NULL COMMENT '订单来源',
  `buyer_id` int(11) DEFAULT NULL COMMENT '买家用户ID',
  `buyer_name` varchar(30) DEFAULT NULL COMMENT '买家名称',
  `seller_id` int(11) DEFAULT NULL COMMENT '卖家用户ID',
  `seller_name` varchar(30) DEFAULT NULL COMMENT '卖家名称',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `sup_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `sale_id` int(11) DEFAULT NULL COMMENT '业务人员ID',
  `sale_name` varchar(1000) DEFAULT NULL COMMENT '业务人名称',
  `delivery_date` date DEFAULT NULL COMMENT '要求交货日期',
  `product_names` varchar(1000) DEFAULT NULL COMMENT '产品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `suk_codes` varchar(1000) DEFAULT NULL COMMENT '商品货号',
  `product_num` int(11) DEFAULT '0' COMMENT '商品购买数量',
  `product_fee` double DEFAULT '0' COMMENT '商品总价',
  `ship_fee_flag` tinyint(4) DEFAULT NULL COMMENT '0=含 1=不含',
  `ship_fee` double DEFAULT '0' COMMENT '配送费用',
  `adjust_fee` double DEFAULT '0' COMMENT '手工调整金额',
  `discount_fee` double DEFAULT '0' COMMENT '订单优惠',
  `total_fee` double DEFAULT '0' COMMENT '商品价格 * 商品数量 + 手工调整金额 - 子订单级订单优惠金额',
  `payment` double DEFAULT '0' COMMENT '实付金额',
  `order_status` varchar(30) DEFAULT NULL COMMENT 'un_audit=未审核 pass=已审核，wait_ship=待发货 ship=已发货 canceled=交易取消 success=成功,refund=退货',
  `seller_remark_status` varchar(30) DEFAULT NULL COMMENT '支付宝交易号',
  `seller_remark` varchar(255) DEFAULT NULL COMMENT '订单备注',
  `order_remark` varchar(255) DEFAULT NULL COMMENT '订单备注',
  `pay_status` varchar(30) DEFAULT 'no_pay' COMMENT '付款状态',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `ship_status` varchar(30) DEFAULT NULL COMMENT '发货状态',
  `ship_time` datetime DEFAULT NULL COMMENT '发货时间',
  `order_end_time` datetime DEFAULT NULL COMMENT '结束时间。交易成功时间(更新交易状态为成功的同时更新)/确认收货时间或者交易关闭时间',
  `receiver_name` varchar(30) DEFAULT NULL COMMENT '收货人',
  `receiver_mobile` varchar(11) DEFAULT NULL COMMENT '收货人手机',
  `receiver_tel` varchar(13) DEFAULT NULL COMMENT '收货人电话',
  `receiver_zip` varchar(6) DEFAULT NULL COMMENT '收货人邮编',
  `receiver_state` varchar(20) DEFAULT NULL COMMENT '收货人省',
  `receiver_city` varchar(20) DEFAULT NULL COMMENT '收货人市',
  `receiver_district` varchar(20) DEFAULT NULL COMMENT '收货人区',
  `receiver_address` varchar(100) DEFAULT NULL COMMENT '收货详细地址',
  `ship_type` varchar(30) DEFAULT NULL COMMENT 'free(卖家包邮),post(平邮),express(快递),ems(EMS)',
  `ship_company` varchar(100) DEFAULT NULL COMMENT '配送公司',
  `ship_no` varchar(30) DEFAULT NULL COMMENT '配送单号',
  `invoice_type` varchar(30) DEFAULT NULL COMMENT 'no=无发票 common=普通 added=增值',
  `invoice_title` varchar(100) DEFAULT NULL COMMENT '发票抬头',
  `invoice_content` varchar(255) DEFAULT NULL COMMENT '发票明细',
  `invoice_bank_name` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `invoice_bank_account` varchar(50) DEFAULT NULL COMMENT '开户账号',
  `invoice_tel` varchar(50) DEFAULT NULL COMMENT '开户电话',
  `invoice_tax_no` varchar(50) DEFAULT NULL COMMENT '纳税人识别号',
  `buyer_stock_flag` tinyint(4) DEFAULT NULL COMMENT '买家入库标记',
  `seller_stock_flag` tinyint(4) DEFAULT NULL COMMENT '卖家出库标记',
  `buyer_pass_flag` tinyint(4) DEFAULT '0' COMMENT '0=未核销\n1=核销',
  `seller_pass_flag` tinyint(4) DEFAULT '0' COMMENT '0=未核销\n1=核销',
  `operate_content` varchar(255) DEFAULT NULL COMMENT '当前操作记录',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  `refund_status` varchar(30) DEFAULT 'unrefund' COMMENT 'refund:退货;unrefund:未退货',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8 COMMENT='订单交易';

-- ----------------------------
--  Table structure for `lh_ord_order_product`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_order_product`;
CREATE TABLE `lh_ord_order_product` (
  `order_product_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `order_code` varchar(30) DEFAULT NULL COMMENT '订单code',
  `product_id` int(11) DEFAULT NULL COMMENT '产品Id',
  `cate_id` text COMMENT '产品类型ID',
  `suk_id` int(11) DEFAULT NULL COMMENT '商品规格ID',
  `suk_code` varchar(30) DEFAULT NULL COMMENT '商品货号',
  `suk_value` varchar(255) DEFAULT NULL COMMENT '产品规格属性值',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `product_sn` varchar(50) DEFAULT NULL COMMENT '产品编号',
  `product_number` int(11) DEFAULT NULL COMMENT '产品数量',
  `product_unit` varchar(10) DEFAULT NULL COMMENT '产品单位',
  `product_price` int(11) DEFAULT NULL COMMENT '产品价格',
  `product_attrs` varchar(1000) DEFAULT NULL COMMENT '产品属性',
  `product_note` varchar(1000) DEFAULT NULL COMMENT '产品备注',
  `product_desc` text COMMENT '产品介绍',
  `product_normal_price` int(11) DEFAULT NULL COMMENT '产品标准价格',
  `adjust_fee` int(11) DEFAULT NULL COMMENT '手工调整金额',
  `discount_fee` int(11) DEFAULT NULL COMMENT '订单优惠',
  `total_fee` int(11) DEFAULT NULL COMMENT '商品价格 * 商品数量 + 手工调整金额 - 子订单级订单优惠金额',
  `payment` int(11) DEFAULT NULL COMMENT '实付金额',
  `order_status` varchar(30) DEFAULT NULL COMMENT '订单状态',
  `ship_status` varchar(30) DEFAULT NULL COMMENT '发货状态',
  `ship_time` datetime DEFAULT NULL COMMENT '发货时间',
  `refund_product_id` int(11) DEFAULT NULL COMMENT '最近退款Id',
  `fefund_status` varchar(20) DEFAULT NULL COMMENT '退款状态',
  `buyer_stock_flag` tinyint(4) DEFAULT NULL COMMENT '买家入库标记',
  `seller_stock_flag` tinyint(4) DEFAULT NULL COMMENT '卖家出库标记',
  `lcomment_level` int(10) DEFAULT NULL COMMENT '评论等级',
  `lcomment_desc` longtext COMMENT '评论详情',
  `is_show_lcomment` tinyint(4) DEFAULT NULL COMMENT '是否显示在前台',
  `is_comment` tinyint(4) DEFAULT '0' COMMENT '是否评论了',
  `tie_id` int(11) DEFAULT '0',
  `deposit_day` int(11) DEFAULT NULL,
  `home_size` int(11) DEFAULT NULL,
  `home_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8 COMMENT='订单商品';

-- ----------------------------
--  Table structure for `lh_ord_record`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_record`;
CREATE TABLE `lh_ord_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `trade_id` int(11) DEFAULT NULL COMMENT '交易Id',
  `trade_status` varchar(20) DEFAULT NULL COMMENT '订单=order 退单=refund',
  `trade_type` varchar(20) DEFAULT NULL COMMENT '订单=order 退单=refund',
  `remark_status` varchar(20) DEFAULT NULL COMMENT '订单=order 退单=refund',
  `content_type` varchar(20) DEFAULT NULL COMMENT '订单=order 退单=refund',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `create_ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `trade_count` double DEFAULT NULL,
  `outtradeno` varchar(45) DEFAULT NULL,
  `tradeno` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='交易操作记录';

-- ----------------------------
--  Table structure for `lh_ord_refund`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_refund`;
CREATE TABLE `lh_ord_refund` (
  `refund_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `refund_code` varchar(30) DEFAULT NULL COMMENT '退单号',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `order_code` varchar(30) DEFAULT NULL COMMENT '订单号',
  `buyer_id` int(11) DEFAULT NULL COMMENT '买家用户ID',
  `buyer_name` varchar(30) DEFAULT NULL COMMENT '买家名称',
  `seller_id` int(11) DEFAULT NULL COMMENT '卖家用户ID',
  `seller_name` varchar(30) DEFAULT NULL COMMENT '卖家名称',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `sup_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `refund_time` datetime DEFAULT NULL COMMENT '退款申请时间',
  `good_return_flag` tinyint(4) DEFAULT NULL COMMENT '0=未退货 1=退货',
  `refund_fee` int(11) DEFAULT NULL COMMENT '退还金额',
  `reason` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `refund_desc` varchar(255) DEFAULT NULL COMMENT '退款说明',
  `good_return_num` int(11) DEFAULT NULL COMMENT '商品退货数量',
  `good_stock_num` int(11) DEFAULT NULL COMMENT '商品退货入库数',
  `address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `refund_status` varchar(30) DEFAULT NULL COMMENT 'un_audit=未审核 pass=审核通过 cancel=取消 ',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `buyer_stock_flag` tinyint(4) DEFAULT NULL COMMENT '买家出库标记',
  `seller_stock_flag` tinyint(4) DEFAULT NULL COMMENT '卖家入库标记',
  `buyer_pass_flag` tinyint(4) DEFAULT '0' COMMENT '0=未核销\n1=核销',
  `seller_pass_flag` tinyint(4) DEFAULT '0' COMMENT '0=未核销\n1=核销',
  `operate_content` varchar(255) DEFAULT NULL COMMENT '当前操作记录',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='退单';

-- ----------------------------
--  Table structure for `lh_ord_refund_product`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_refund_product`;
CREATE TABLE `lh_ord_refund_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `refund_code` varchar(30) DEFAULT NULL COMMENT '退单号',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `order_product_id` int(11) DEFAULT NULL COMMENT '订单商品ID',
  `order_code` varchar(30) DEFAULT NULL COMMENT '订单号',
  `refund_time` datetime DEFAULT NULL COMMENT '退款申请时间',
  `reason` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `refund_desc` varchar(255) DEFAULT NULL COMMENT '退款说明',
  `good_stock_num` int(11) DEFAULT NULL COMMENT '商品退货入库数',
  `address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `good_status` varchar(30) DEFAULT NULL COMMENT ' BUYER_NOT_RECEIVED (买家未收到货) BUYER_RECEIVED (买家已收到货) BUYER_RETURNED_GOODS (买家已退货)',
  `refund_status` varchar(30) DEFAULT NULL COMMENT 'un_audit=未审核 pass=审核通过 cancel=取消 ',
  `good_return_flag` tinyint(4) DEFAULT NULL COMMENT '0=未退货 1=退货',
  `product_id` int(11) DEFAULT NULL COMMENT '产品Id',
  `cate_id` int(11) DEFAULT NULL COMMENT '产品类型ID',
  `suk_id` int(11) DEFAULT NULL COMMENT '商品规格ID',
  `suk_code` varchar(30) DEFAULT NULL COMMENT '商品货号',
  `suk_value` varchar(255) DEFAULT NULL COMMENT '产品规格属性值',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `product_price` int(11) DEFAULT NULL COMMENT '产品价格',
  `good_return_num` int(11) DEFAULT NULL COMMENT '商品退货数量',
  `refund_fee` int(11) DEFAULT NULL COMMENT '退还金额',
  `product_attrs` varchar(1000) DEFAULT NULL COMMENT '产品属性',
  `product_unit` varchar(10) DEFAULT NULL COMMENT '产品单位',
  `good_return_time` datetime DEFAULT NULL COMMENT '退货时间',
  `ship_company` varchar(100) DEFAULT NULL COMMENT '物流公司名称',
  `ship_no` varchar(30) DEFAULT NULL COMMENT '退货运单号',
  `ship_type` varchar(30) DEFAULT NULL COMMENT '物流方式',
  `buyer_stock_flag` tinyint(4) DEFAULT NULL COMMENT '买家出库标记',
  `seller_stock_flag` tinyint(4) DEFAULT NULL COMMENT '卖家入库标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='退单详细';

-- ----------------------------
--  Table structure for `lh_ord_shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `lh_ord_shopping_cart`;
CREATE TABLE `lh_ord_shopping_cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `buyer_id` int(11) DEFAULT NULL COMMENT '买家用户ID',
  `seller_id` int(11) DEFAULT NULL COMMENT '卖家用户ID',
  `cus_id` int(11) DEFAULT NULL COMMENT '客户ID',
  `sup_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `product_id` int(11) DEFAULT NULL COMMENT '产品Id',
  `suk_id` int(11) DEFAULT NULL COMMENT '商品货号',
  `suk_value` varchar(255) DEFAULT NULL COMMENT '产品规格属性值',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `product_no` varchar(100) DEFAULT NULL COMMENT '产品编号',
  `product_number` int(11) DEFAULT NULL COMMENT '产品数量',
  `product_unit` varchar(10) DEFAULT NULL COMMENT '产品单位',
  `product_price` float DEFAULT NULL COMMENT '产品价格',
  `product_attrs` text COMMENT '产品属性 json 格式 {"属性1":"值1", "属性2":"值2"}',
  `product_note` varchar(255) DEFAULT NULL COMMENT '产品备注',
  `create_ip` varchar(70) DEFAULT NULL COMMENT '添加IP',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `tie_id` int(11) DEFAULT '0',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  `deposit_day` int(11) DEFAULT NULL,
  `home_size` int(11) DEFAULT NULL,
  `home_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `ix_ord_shopping_cart_memid` (`buyer_id`) USING BTREE,
  KEY `ix_ord_shopping_cart_sesid` (`seller_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=640 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- ----------------------------
--  Table structure for `lh_pro_cate_ref_prop`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_cate_ref_prop`;
CREATE TABLE `lh_pro_cate_ref_prop` (
  `key_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `cate_id` int(11) NOT NULL COMMENT '分类ID',
  `prop_id` int(11) NOT NULL COMMENT '属性ID',
  `prop_name` varchar(50) NOT NULL COMMENT '属性值,有可能和属性表的属性名称不同',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `required` tinyint(4) DEFAULT NULL COMMENT '是否必选',
  `is_key_prop` tinyint(4) DEFAULT NULL COMMENT '是否关键属性',
  `is_search` tinyint(4) DEFAULT NULL COMMENT '是否可搜索',
  `prop_vids` varchar(1000) DEFAULT NULL COMMENT '可选属性值ID集合（逗号分隔）',
  `search_prop_vids` varchar(1000) DEFAULT NULL COMMENT '可搜索属性值ID集合（逗号分隔）',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  `publish_status` tinyint(4) DEFAULT NULL COMMENT '发布状态',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `publish_user` varchar(50) DEFAULT NULL COMMENT '发布人',
  `is_sale_prop` tinyint(4) DEFAULT NULL COMMENT '是否销售属性',
  PRIMARY KEY (`key_id`),
  KEY `cate_id` (`cate_id`) USING BTREE,
  KEY `proop_id` (`prop_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品分类属性关联表';

-- ----------------------------
--  Table structure for `lh_pro_product`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_product`;
CREATE TABLE `lh_pro_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_name` varchar(100) NOT NULL COMMENT '产品名称',
  `product_number` varchar(255) NOT NULL COMMENT '产品编号',
  `product_desc` text COMMENT '产品描述',
  `company_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `company_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `cate_ids` text COMMENT '主分类勾选',
  `ref_cate_ids` varchar(255) DEFAULT NULL COMMENT '关联分类IDs,可多个分类，用逗号分隔，默认为空字符串',
  `product_series` varchar(20) DEFAULT NULL COMMENT '产品系列',
  `product_custom_number` varchar(100) DEFAULT NULL COMMENT '产品自定义编号',
  `product_ename` varchar(100) DEFAULT NULL COMMENT '产品英文名',
  `country` varchar(200) DEFAULT NULL COMMENT '产品所在国家',
  `province` int(11) DEFAULT NULL COMMENT '产品所在省',
  `city` int(11) DEFAULT NULL COMMENT '产品所在城市',
  `county` int(11) DEFAULT NULL COMMENT '产品所在区',
  `image_num` varchar(255) DEFAULT NULL COMMENT '产品第一张图片,产品图片编号',
  `image_nums` varchar(1000) DEFAULT NULL COMMENT '产品第一张图片,产品图片编号',
  `keyword` varchar(100) DEFAULT NULL COMMENT '产品关键字',
  `supply_amount` varchar(20) DEFAULT NULL COMMENT '供货量',
  `supply_amount_unit` varchar(10) DEFAULT NULL COMMENT '供货量单位',
  `product_order` int(11) DEFAULT NULL COMMENT '产品排序值',
  `sell_status` tinyint(4) DEFAULT NULL COMMENT '销售状态 0、停售 1、出售',
  `trade_status` tinyint(4) DEFAULT NULL COMMENT '销售属性 0.不可交易 1.可交易',
  `product_property` varchar(2000) DEFAULT NULL COMMENT '产品属性 字符串格式: {颜色:红色（Tab）尺码:XL}',
  `product_unit` varchar(10) DEFAULT NULL COMMENT '产品计量单位',
  `market_price` double DEFAULT NULL COMMENT '市场价',
  `preferential_price` double DEFAULT NULL COMMENT '活动价',
  `cost_price` double DEFAULT NULL COMMENT '成本价',
  `product_price` double DEFAULT NULL COMMENT '产品参考价格',
  `price_unit` varchar(10) DEFAULT NULL COMMENT '产品参考价格单位',
  `price_type` tinyint(3) DEFAULT NULL COMMENT '0 统一批发价, 1 按数量制定批发价,2 按规格报价',
  `whole_price` varchar(1000) DEFAULT NULL COMMENT '批发价, json格式: {1:123.44, 5:110.23, 10:100}',
  `min_amount` int(11) DEFAULT NULL COMMENT '产品重量',
  `stock` int(11) DEFAULT NULL COMMENT '产品总库存',
  `stock_locked` int(11) DEFAULT NULL COMMENT '产品锁定库存',
  `sell_start_time` datetime DEFAULT NULL COMMENT '销售开始时间',
  `sell_end_time` datetime DEFAULT NULL COMMENT '销售结束时间',
  `sell_count` bigint(20) DEFAULT '0' COMMENT '销售量',
  `trade_model` varchar(200) DEFAULT NULL COMMENT 'trade_model',
  `republish_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '重发时间',
  `update_new_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `prop_id_str` varchar(2500) DEFAULT NULL COMMENT '属性ID字符串，格式为pid:vid;pid:vid;,默认为空字符串',
  `prop_str` varchar(2500) DEFAULT NULL COMMENT '属性字符串,格式为pid1:vid1:pname1:pvalue1:单位（有时候是可自行输入的）;',
  `sub_site` varchar(100) DEFAULT NULL COMMENT '来源站点',
  `product_status` tinyint(4) DEFAULT NULL COMMENT '产品状态 上线 下线 删除',
  `invalid_time` timestamp NULL DEFAULT NULL COMMENT '失效时间',
  `on_line_time` datetime DEFAULT NULL COMMENT '上线时间',
  `validate_date` int(11) DEFAULT NULL COMMENT '有效期',
  `add_time` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `add_ip` varchar(100) DEFAULT NULL COMMENT '添加IP',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `customer_status` tinyint(4) DEFAULT '0' COMMENT '是是否团购',
  `temperature` double DEFAULT NULL COMMENT '温度',
  `favorable_status` tinyint(4) DEFAULT '0' COMMENT '是否特价',
  `day_price` double DEFAULT NULL,
  `isday` tinyint(4) DEFAULT '0',
  `tie_id` int(11) DEFAULT '0',
  `day_num` int(11) DEFAULT NULL,
  `deposit_status` tinyint(4) DEFAULT '0' COMMENT '是否出租',
  `deposit` double DEFAULT NULL COMMENT '出租押金',
  `deposit_day` int(11) DEFAULT NULL COMMENT '出租天数',
  `deposit_start_time` datetime DEFAULT NULL,
  `deposit_end_time` datetime DEFAULT NULL,
  `home_status` tinyint(4) DEFAULT '0' COMMENT '是否家政',
  `home_price` double DEFAULT NULL COMMENT '家政初始价格',
  `home_start_time` datetime DEFAULT NULL,
  `home_end_time` datetime DEFAULT NULL,
  `area_price` double DEFAULT NULL COMMENT '每平方单价',
  `area_size` int(11) DEFAULT NULL COMMENT '总平方米',
  `everyday_price` double DEFAULT NULL COMMENT '每天单价',
  `home_day` int(11) DEFAULT NULL COMMENT '家政服务天数',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `uq_pro_product_number` (`product_number`),
  KEY `product_series` (`product_series`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
--  Table structure for `lh_pro_product_category`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_product_category`;
CREATE TABLE `lh_pro_product_category` (
  `cate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `cate_name` varchar(255) NOT NULL COMMENT '分类名称',
  `cate_code` varchar(60) NOT NULL COMMENT '分类代码',
  `cate_level` bigint(20) NOT NULL COMMENT '分类级别',
  `type_id` int(11) DEFAULT NULL COMMENT '产品类型ID(无用)',
  `parent_cate_id` int(11) DEFAULT NULL COMMENT '上级分类',
  `cate_status` tinyint(4) DEFAULT NULL COMMENT '分类状态',
  `cate_delete` tinyint(4) DEFAULT NULL COMMENT '分类删除状态',
  `cate_order` int(11) DEFAULT NULL COMMENT '分类排序值',
  `type_code` varchar(12) DEFAULT NULL COMMENT 'type_code',
  `mall_type` varchar(100) DEFAULT '0' COMMENT '所属市场：成品批发(mall_type)',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `publish_user` varchar(50) DEFAULT NULL COMMENT '发布人',
  `delete_user` varchar(50) DEFAULT NULL COMMENT '删除人',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  `image_logo` varchar(100) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`cate_id`),
  UNIQUE KEY `uq_pro_product_category_cate_code` (`cate_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9452 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
--  Table structure for `lh_pro_product_favorable`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_product_favorable`;
CREATE TABLE `lh_pro_product_favorable` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `amount` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL COMMENT '产品Id',
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL COMMENT '	',
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单商品';

-- ----------------------------
--  Table structure for `lh_pro_product_series`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_product_series`;
CREATE TABLE `lh_pro_product_series` (
  `product_series_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品系列ID',
  `product_series_name` varchar(50) NOT NULL COMMENT '产品系列名称',
  `product_series_desc` varchar(200) NOT NULL COMMENT '产品系列描述',
  `product_series_order` int(11) DEFAULT NULL COMMENT '产品系列排序值',
  `member_id` int(11) DEFAULT NULL COMMENT '会员ID',
  `company_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `parent_sid` int(11) DEFAULT NULL COMMENT '父分类ID，默认为0',
  `is_parent` tinyint(2) DEFAULT NULL COMMENT '是否是父分类',
  `img_code` varchar(100) DEFAULT NULL COMMENT '图片地址',
  `has_tile_figure` tinyint(4) DEFAULT '0' COMMENT '是否有平铺图',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`product_series_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品系列表';

-- ----------------------------
--  Table structure for `lh_pro_product_sku`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_product_sku`;
CREATE TABLE `lh_pro_product_sku` (
  `sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '规格ID',
  `sku_code` varchar(50) DEFAULT NULL COMMENT '商家编码',
  `pro_id` int(11) NOT NULL COMMENT '商品ID',
  `properties_name` varchar(500) NOT NULL COMMENT '规格属性字符串,格式为pid1:vid1:pname1:pvalue1（有时候是可自行输入的）;',
  `prop_id_str` varchar(500) NOT NULL COMMENT '规格属性ID组合字符串,格式为pid1:vid1;pid2:vid2',
  `sku_add_stock` int(11) NOT NULL DEFAULT '0' COMMENT '规格库存量',
  `sku_stock` int(11) NOT NULL DEFAULT '0' COMMENT '规格库存量',
  `sku_price` int(11) NOT NULL DEFAULT '0' COMMENT '规格价格,单位为元',
  `sku_retail_price` int(11) NOT NULL DEFAULT '0' COMMENT '建议零售价,单位为元',
  `sample_flag` tinyint(4) DEFAULT NULL COMMENT '0=非样品 1=样品',
  `sup_id` int(11) DEFAULT NULL COMMENT '供应商Id',
  `sup_suk_code` varchar(255) DEFAULT NULL COMMENT '供应商规格编码',
  `sup_sku_price` int(11) DEFAULT NULL COMMENT '供应价格',
  PRIMARY KEY (`sku_id`),
  KEY `pro_id` (`pro_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='商品规格表';

-- ----------------------------
--  Table structure for `lh_pro_prop_value`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_prop_value`;
CREATE TABLE `lh_pro_prop_value` (
  `prop_vid` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性值ID',
  `prop_id` int(11) DEFAULT NULL COMMENT '属性ID',
  `prop_group` varchar(150) DEFAULT NULL COMMENT '属性分组，同属性表的属性组',
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID，分类ID和属性ID才能唯一确定此分类下的属性有什么属性值，为0的情况下是各个分类都可以使用',
  `taobao_prop_id` int(11) DEFAULT NULL COMMENT '淘宝属性值ID，为0说明不是淘宝属性值',
  `prop_name` varchar(150) DEFAULT NULL COMMENT '属性名称',
  `prop_value` varchar(150) DEFAULT NULL COMMENT '属性值',
  `delete_status` tinyint(4) DEFAULT NULL COMMENT '属性值删除状态',
  `sort_order` int(11) DEFAULT NULL COMMENT '排序',
  `prop_unit` varchar(30) DEFAULT NULL COMMENT '单位',
  `is_parent` tinyint(1) DEFAULT NULL COMMENT 'is_parent',
  `prop_pvid` int(11) DEFAULT NULL COMMENT 'prop_pvid',
  `delete_user` varchar(50) DEFAULT NULL COMMENT '删除',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`prop_vid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品属性值表';

-- ----------------------------
--  Table structure for `lh_pro_properties`
-- ----------------------------
DROP TABLE IF EXISTS `lh_pro_properties`;
CREATE TABLE `lh_pro_properties` (
  `prop_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `prop_name` varchar(50) NOT NULL COMMENT '属性名称',
  `prop_type` varchar(50) NOT NULL COMMENT '属性值类型。可选值： multiCheck(枚举多选) optional(枚举单选) multiCheckText(枚举可输入多选) optionalText(枚举可输入单选) text(非枚举可输入)',
  `prop_group` varchar(100) DEFAULT NULL COMMENT '属性分组',
  `unit_str` varchar(50) DEFAULT NULL COMMENT '属性单位格式 单位1|单位2',
  `parent_pid` int(11) DEFAULT NULL COMMENT '上级属性ID',
  `parent_vid` int(11) DEFAULT NULL COMMENT '上级属性值ID',
  `required` tinyint(4) NOT NULL COMMENT '是否必选',
  `is_key_prop` tinyint(4) NOT NULL COMMENT '是否关键属性',
  `is_sale_prop` tinyint(4) NOT NULL COMMENT '是否销售属性',
  `delete_status` tinyint(4) NOT NULL COMMENT '删除状态',
  `taobao_prop_id` int(11) DEFAULT NULL COMMENT '淘宝属性ID,为0时说明和淘宝无关的属性',
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID,预留字段，以后属性管理的时候可能会用到',
  `prop_alias` varchar(50) DEFAULT NULL COMMENT '属性别名',
  `is_enum_prop` tinyint(4) DEFAULT NULL COMMENT '是否枚举属性',
  `is_input_prop` tinyint(4) DEFAULT NULL COMMENT '在is_enum_prop是true的前提下，是否是卖家可以自行输入的属性',
  `prop_order` int(4) DEFAULT NULL COMMENT '属性排序',
  `is_search` tinyint(2) DEFAULT NULL COMMENT '是否可搜索',
  `publish_status` tinyint(2) DEFAULT NULL COMMENT '发布状态',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `publish_user` varchar(50) DEFAULT NULL COMMENT '发布人',
  `delete_user` varchar(50) DEFAULT NULL COMMENT '删除人',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `prop_remark` varchar(255) DEFAULT NULL COMMENT '属性描述',
  `check_type` tinyint(2) DEFAULT NULL COMMENT '验证类型',
  `expression` varbinary(255) DEFAULT NULL COMMENT '表达式或者正则',
  PRIMARY KEY (`prop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

-- ----------------------------
--  Table structure for `lh_rec_info`
-- ----------------------------
DROP TABLE IF EXISTS `lh_rec_info`;
CREATE TABLE `lh_rec_info` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) DEFAULT NULL COMMENT '推荐名称',
  `rec_refInfo_id` int(11) DEFAULT NULL COMMENT '推荐实体ID',
  `rec_type` int(11) DEFAULT NULL COMMENT '推荐类型',
  `rec_comment` varchar(255) DEFAULT NULL COMMENT '推荐描述',
  `rec_img` varchar(255) DEFAULT NULL COMMENT '推荐图片',
  `rec_url` varchar(255) DEFAULT NULL COMMENT '推荐url',
  `rec_order` int(11) DEFAULT NULL COMMENT '排序',
  `rec_status` int(11) DEFAULT NULL COMMENT '推荐状态',
  `rec_available_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `rec_expire_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `rec_website` varchar(255) DEFAULT NULL COMMENT '推荐的网站',
  `rec_keyword` varchar(255) DEFAULT NULL COMMENT '推荐关键词',
  `click_count` int(11) DEFAULT NULL COMMENT '统计',
  `order_type` int(11) DEFAULT NULL COMMENT '排序类型',
  `place_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_rec_place`
-- ----------------------------
DROP TABLE IF EXISTS `lh_rec_place`;
CREATE TABLE `lh_rec_place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `place_title` varchar(255) DEFAULT NULL,
  `rec_place_code` varchar(100) DEFAULT NULL,
  `place_status` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_sup_info`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sup_info`;
CREATE TABLE `lh_sup_info` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sup_code` varchar(30) DEFAULT NULL COMMENT '供应商编号',
  `sup_name` varchar(100) DEFAULT NULL COMMENT '供应商名称',
  `account_id` int(11) DEFAULT NULL COMMENT '供应商用户Id',
  `company_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `company_user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `contacter_name` varchar(100) DEFAULT NULL COMMENT '联系人',
  `contacter_mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `contacter_tel` varchar(13) DEFAULT NULL COMMENT '联系电话',
  `contacter_state` varchar(20) DEFAULT NULL COMMENT '所在省',
  `contacter_city` varchar(20) DEFAULT NULL COMMENT '所在市',
  `contacter_district` varchar(20) DEFAULT NULL COMMENT '所在区县',
  `contacter_address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `main_product` varchar(50) DEFAULT NULL COMMENT '主营产品',
  `sup_url` varchar(255) DEFAULT NULL COMMENT '网址',
  `use_name` varchar(30) DEFAULT NULL COMMENT '跟单员',
  `coop_status` varchar(20) DEFAULT NULL COMMENT 'coop=合作 end=终止',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`sup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='供应商信息';

-- ----------------------------
--  Table structure for `lh_sys_account`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_account`;
CREATE TABLE `lh_sys_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `account_status` tinyint(1) DEFAULT '1' COMMENT '用户状态：1、启用；0、禁用',
  `comp_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `qfc_account_id` bigint(20) DEFAULT NULL COMMENT '轻纺城账号ID',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='lh_sys_account';

-- ----------------------------
--  Table structure for `lh_sys_company_config`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_company_config`;
CREATE TABLE `lh_sys_company_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `comp_id` int(11) DEFAULT NULL COMMENT '公司ID',
  `config_name` varchar(255) DEFAULT NULL COMMENT '配置名称',
  `config_code` varchar(255) DEFAULT NULL COMMENT '配置code',
  `config_content` varchar(2000) DEFAULT NULL COMMENT '配置内容',
  `config_order` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司配置表';

-- ----------------------------
--  Table structure for `lh_sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_config`;
CREATE TABLE `lh_sys_config` (
  `cfg_code` varchar(50) NOT NULL COMMENT '代码',
  `cfg_name` varchar(100) DEFAULT NULL COMMENT '名称',
  `cfg_value` text COMMENT '值',
  `cfg_type` tinyint(4) DEFAULT NULL COMMENT '类型 0 - rw , 1 - r',
  `cfg_free_price` double DEFAULT NULL COMMENT '满多少包邮',
  `cfg_full_price` varchar(255) DEFAULT NULL COMMENT '满多少送多少用逗号隔开',
  `cfg_send_price` varchar(255) DEFAULT NULL COMMENT '满多少送多少块钱的红包，用逗号隔开和cfg_full_price一一对应',
  `cfg_postal_fees` double(255,0) DEFAULT NULL COMMENT '邮费',
  `cfg_red_price` double(255,0) DEFAULT NULL COMMENT '满多少才能使用红包',
  PRIMARY KEY (`cfg_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置信息';

-- ----------------------------
--  Table structure for `lh_sys_region`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_region`;
CREATE TABLE `lh_sys_region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `region_name` varchar(255) DEFAULT NULL,
  `region_order` int(11) DEFAULT NULL,
  `region_level` int(11) DEFAULT NULL,
  `region_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3932 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `lh_sys_sequence`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_sequence`;
CREATE TABLE `lh_sys_sequence` (
  `seq_code` varchar(50) NOT NULL COMMENT '代码',
  `seq_name` varchar(100) NOT NULL COMMENT '名称',
  `seq_value` bigint(20) NOT NULL DEFAULT '1' COMMENT '值',
  `update_time` datetime NOT NULL COMMENT '时间',
  PRIMARY KEY (`seq_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于生成序列';

-- ----------------------------
--  Table structure for `lh_sys_system_log`
-- ----------------------------
DROP TABLE IF EXISTS `lh_sys_system_log`;
CREATE TABLE `lh_sys_system_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operate_id` varchar(30) DEFAULT NULL COMMENT '操作ID',
  `operate_module` varchar(20) DEFAULT NULL COMMENT '产品=product 供应商=supplier 订单=order',
  `operate_name` varchar(255) DEFAULT NULL COMMENT '操作名',
  `method_name` varchar(255) DEFAULT NULL COMMENT '方法名',
  `method_params` text COMMENT '参数',
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `operate_ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
--  Table structure for `lh_tie_products`
-- ----------------------------
DROP TABLE IF EXISTS `lh_tie_products`;
CREATE TABLE `lh_tie_products` (
  `tie_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT '0',
  `t_desc` varchar(512) DEFAULT '',
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(30) DEFAULT NULL,
  `save_money` double DEFAULT NULL,
  PRIMARY KEY (`tie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `manager`
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '后台管理员 id',
  `account` varchar(45) DEFAULT NULL COMMENT '账号',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `create_user` varchar(45) DEFAULT NULL COMMENT '	',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `nickname` varchar(45) DEFAULT NULL,
  `real_name` varchar(45) DEFAULT NULL,
  `work_no` varchar(45) DEFAULT NULL COMMENT '工号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `manager_to_role`
-- ----------------------------
DROP TABLE IF EXISTS `manager_to_role`;
CREATE TABLE `manager_to_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `int_1` int(11) DEFAULT NULL,
  `int_2` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `news_info`
-- ----------------------------
DROP TABLE IF EXISTS `news_info`;
CREATE TABLE `news_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文档编号',
  `image_logo` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '标题(产品名)',
  `create_user` char(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者',
  `seo_desc` text CHARACTER SET utf8 COMMENT '摘要',
  `keyword` char(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '关键词',
  `update_user` char(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '编辑者',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `content` varchar(10000) CHARACTER SET utf8 DEFAULT NULL,
  `rank` int(11) DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2725337 DEFAULT CHARSET=gbk COMMENT='资讯(文档)主表';

-- ----------------------------
--  Table structure for `red_packet`
-- ----------------------------
DROP TABLE IF EXISTS `red_packet`;
CREATE TABLE `red_packet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cus_id` int(11) DEFAULT NULL COMMENT '所属用户',
  `pdesc` text COMMENT '描述',
  `p_value` double DEFAULT NULL COMMENT '面值',
  `p_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `status` varchar(45) DEFAULT NULL COMMENT '状态',
  `is_use` tinyint(4) DEFAULT NULL COMMENT '是否已经使用',
  `p_from` varchar(45) DEFAULT NULL COMMENT '来源',
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `s_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `e_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `resources`
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `int_1` int(11) DEFAULT NULL,
  `int_2` int(11) DEFAULT NULL,
  `uri` varchar(450) DEFAULT NULL,
  `description` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `resources_copy`
-- ----------------------------
DROP TABLE IF EXISTS `resources_copy`;
CREATE TABLE `resources_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `int_1` int(11) DEFAULT NULL,
  `int_2` int(11) DEFAULT NULL,
  `uri` varchar(450) DEFAULT NULL,
  `description` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `int_1` int(11) DEFAULT NULL,
  `int_2` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL COMMENT '角色名称',
  `description` varchar(450) DEFAULT NULL COMMENT '描述',
  `name_ch` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `role_to_resources`
-- ----------------------------
DROP TABLE IF EXISTS `role_to_resources`;
CREATE TABLE `role_to_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_user` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_user` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `more1` varchar(45) DEFAULT NULL,
  `more2` varchar(45) DEFAULT NULL,
  `more3` varchar(45) DEFAULT NULL,
  `int_1` int(11) DEFAULT NULL,
  `int_2` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
