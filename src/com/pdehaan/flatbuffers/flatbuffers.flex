package com.pdehaan.flatbuffers;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.pdehaan.flatbuffers.psi.FlatbuffersTypes;
import com.intellij.psi.TokenType;

%%

%class FlatbuffersLexer
%implements FlexLexer, FlatbuffersTypes
%unicode

%function advance
%type IElementType
%eof{ return;
%eof}

EOL = \r|\n|\r\n
WHITE_SPACE = " "|\t|\f
INPUT_CHARACTER = [^\r\n]

DIGIT = [0-9]
HEXADECIMAL_DIGIT = [0-9a-fA-F]
LETTER = [:letter:]|"_"

IDENTIFIER = ({LETTER})({LETTER}|{DIGIT})*

LINE_COMMENT = "/""/"{INPUT_CHARACTER}*

DECIMAL_LITERAL = {DIGIT}{DIGIT}*
HEXADECIMAL_LITERAL = "0x" {HEXADECIMAL_DIGIT}{HEXADECIMAL_DIGIT}*

NUM_INT = {DECIMAL_LITERAL}|{HEXADECIMAL_LITERAL}
NUM_DOUBLE = ({DIGIT}+(("."{DIGIT}+)|((e|E)"-"?{DIGIT}+)))
STRING_DOUBLE_QUOTED = \"(\\\"|[^\"\r\n])*(\")

%%

{LINE_COMMENT}            {return (COMMENT);}

{STRING_DOUBLE_QUOTED}    {return (STRING_LITERAL);}

{WHITE_SPACE}+            {return (TokenType.WHITE_SPACE);}
{EOL}+                    {return (TokenType.WHITE_SPACE);}

{NUM_INT}                 {return (INTEGER_LITERAL);}
{NUM_DOUBLE}              {return (FLOAT_LITERAL);}

"("                       {return (OPEN_PARENTHESIS);}
")"                       {return (CLOSE_PARENTHESIS);}
"["                       {return (OPEN_BRACE);}
"]"                       {return (CLOSE_BRACE);}
"{"                       {return (OPEN_BLOCK);}
"}"                       {return (CLOSE_BLOCK);}

"."                       {return (DOT);}
"="                       {return (EQUAL);}
";"                       {return (SEMICOLON);}
":"                       {return (COLON);}
","                       {return (COMMA);}

"include"                 {return (INCLUDE);}
"namespace"               {return (NAMESPACE);}
"attribute"               {return (ATTRIBUTE);}
"table"                   {return (TABLE);}
"struct"                  {return (STRUCT);}
"enum"                    {return (ENUM);}
"union"                   {return (UNION);}
"root_type"               {return (ROOT_TYPE);}

"true"                    {return (TRUE);}
"false"                   {return (FALSE);}

"bool"                    {return (BOOL);}
"byte"                    {return (BYTE);}
"ubyte"                   {return (UBYTE);}
"short"                   {return (SHORT);}
"ushort"                  {return (USHORT);}
"int"                     {return (INT);}
"uint"                    {return (UINT);}
"float"                   {return (FLOAT);}
"long"                    {return (LONG);}
"ulong"                   {return (ULONG);}
"double"                  {return (DOUBLE);}
"string"                  {return (STRING);}

{IDENTIFIER}              {return (IDENTIFIER);}

.                         {return (TokenType.BAD_CHARACTER);}
