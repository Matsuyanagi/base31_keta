#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#-----------------------------------------------------------------------------
#	2進数 N ビットの数値を M 進数で表記したときの桁数
#	
#	M 進数 K 桁で表せる 2進数 N ビット数
#	
#		桁数 = ( Math.log( 2 ** N ) / Math.log( M ) ).ceil
#	
#		2進数桁数 = ( Math.log( base ** keta ) / Math.log( 2 ) ).floor
#	
#	2013-03-19
#-----------------------------------------------------------------------------
require 'pp'
require 'fileutils'
require 'date'
require 'time'
require 'strscan'

Encoding.default_external="utf-8"
#-----------------------------------------------------------------------------
#	
#-----------------------------------------------------------------------------
# 出力ファイル名
filename = 'keta.txt'

# true : 区切り線を出力する
flag_verbatim = true

# 2の N 乗情報量
# EXP_2_MIN = 4
# EXP_2_MAX = 128

# M 進数
DECIMAL_MIN = 2
DECIMAL_MAX = 64

# K 桁
KETA_MIN = 1
KETA_MAX = 128



# ファイル書き込み
File.open( filename, "w" ){ |fp|
	
	# N ビット数で区切り線を引く
	bitnum_split_number_array = [ 8, 16, 24, 32, 40, 48, 56, 64 ]
	# M 進数で区切り線を引く
	base_split_number_array = [ 10, 16, 32 ]
	
	fp.puts( " M 進数 K 桁 で表せる 2^N ビット数" )
	fp.write( "M＼K " )
	
	
	# 桁数ヘッダ行
	( KETA_MIN .. KETA_MAX ).each do |keta|
		fp.write( " %4d" % keta )
		
		if flag_verbatim && bitnum_split_number_array.include?( keta )
			# 区切り線出力
			fp.write( "|" )
		end
	end
	
	fp.puts ""
	
	# 本文行
	( DECIMAL_MIN .. DECIMAL_MAX ).each do |base|
		fp.write( "%2d : " % base )
		( KETA_MIN .. KETA_MAX ).each do |keta|
			
			
			fp.write( " %4d" % ( ( Math.log( base ** keta ) / Math.log( 2 ) ).floor ) )
			
			
			if flag_verbatim && bitnum_split_number_array.include?( keta )
				# 区切り線出力
				fp.write( "|" )
			end
		end
		fp.puts ""
		
		if flag_verbatim
			# 区切り線出力
			if base_split_number_array.include? base
				fp.write( "-----" )
				fp.write( "-----" * ( KETA_MIN .. KETA_MAX ).to_a.size )
				fp.write( "-" * bitnum_split_number_array.size )
				fp.puts ""
			end
		end
	end
}




