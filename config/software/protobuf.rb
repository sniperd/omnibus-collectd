#
# Copyright:: Copyright (c) 2013 Robby Dyer
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
name "protobuf"
default_version "2.5.0"

source :url => "https://github.com/protocolbuffers/protobuf/releases/download/v#{version}/protobuf-#{version}.tar.bz2",
       :md5 => "a72001a9067a4c2c4e0e836d0f92ece4"

relative_path "protobuf-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}",
}

build do
  command [
            "./configure",
            "--prefix=#{install_dir}/embedded",
           ].join(" "), :env => env

  command "make -j #{workers}", :env => env
  command "make install", :env => env
end
