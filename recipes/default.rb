#
# Cookbook Name:: wiwproject
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'wiwproject::db'
include_recipe 'wiwproject::http'
include_recipe 'wiwproject::blog'
