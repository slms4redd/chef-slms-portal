#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Attributes:: jai
#
# (C) 2013, FAO Forestry Department (http://www.fao.org/forestry/)
#
# This application is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation;
# version 3.0 of the License.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

default['unredd-nfms-portal']['jai']['arch'] = kernel['machine'] =~ /x86_64/ ? "amd64" : "i586"

case kernel['machine']
when /x86_64/
  default['unredd-nfms-portal']['jai']['jai_imageio_checksum'] = "ee467f5a7883df332034f70a1a7094277121ca66798d2337cb867b417aaccaaa"
  default['unredd-nfms-portal']['jai']['jai_checksum']         = "4bf0d26acbedc9e203059b18f8a1a7bfef0b448cb5515b8c1b530706e68eb75a"
else
  default['unredd-nfms-portal']['jai']['jai_imageio_checksum'] = "ee467f5a7883df332034f70a1a7094277121ca66798d2337cb867b417aacc233"
  default['unredd-nfms-portal']['jai']['jai_checksum']         = "00e68ee1742f972e1602913afcf095e4ca49c17e2df1d2c0938ecb267d41f94f"
end

default['unredd-nfms-portal']['jai']['jai_version']          = "1.1.3"
default['unredd-nfms-portal']['jai']['jai_imageio_version']  = "1.1"
