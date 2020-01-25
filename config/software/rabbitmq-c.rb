#
# Copyright:: Copyright (c) 2013 Stratus Technologies
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "rabbitmq-c"
default_version "rabbitmq-c-v0.10.0"

dependency "autoconf"
dependency "automake"
dependency "libtool"

source :url => "https://github.com/alanxz/rabbitmq-c/archive/v0.10.0.tar.gz",
       :md5 => "6f09f0cb07cea221657a768bd9c7dff7"

reconf_env = {"PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"}

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "OPENSSL_ROOT_DIR" => "#{install_dir}/embedded"
}

build do
  # configure and build
  #command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "find #{install_dir}/embedded/lib"
  command "cd rabbitmq-c-0.10.0 && #{install_dir}/embedded/bin/cmake -DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded .", :env => configure_env
  command "cd rabbitmq-c-0.10.0 && #{install_dir}/embedded/bin/cmake --build . [--config Release] --target install", :env => configure_env
end
