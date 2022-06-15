LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY char_rom IS
	PORT
	(
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock				: 	IN STD_LOGIC ;
		rom_mux_output		:	OUT STD_LOGIC
	);
END char_rom;


ARCHITECTURE SYN OF char_rom IS

	SIGNAL rom_data		: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL rom_address	: STD_LOGIC_VECTOR (8 DOWNTO 0);

	COMPONENT altsyncram
	GENERIC (
		address_aclr_a			: STRING;
		clock_enable_input_a	: STRING;
		clock_enable_output_a	: STRING;
		init_file				: STRING;
		intended_device_family	: STRING;
		lpm_hint				: STRING;
		lpm_type				: STRING;
		numwords_a				: NATURAL;
		operation_mode			: STRING;
		outdata_aclr_a			: STRING;
		outdata_reg_a			: STRING;
		widthad_a				: NATURAL;
		width_a					: NATURAL;
		width_byteena_a			: NATURAL
	);
	PORT (
		clock0		: IN STD_LOGIC ;
		address_a	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		q_a			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT;

BEGIN

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_aclr_a => "NONE",
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "tcgrom.mif",
		intended_device_family => "Cyclone III",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 512,
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		widthad_a => 9,
		width_a => 8,
		width_byteena_a => 1
	)
	PORT MAP (
		clock0 => clock,
		address_a => rom_address,
		q_a => rom_data
	);

	rom_address <= character_address & font_row;
	rom_mux_output <= rom_data (CONV_INTEGER(NOT font_col(2 DOWNTO 0)));

END SYN;

-- Character codes defined for readability
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE CHARS IS
	constant C_A : std_logic_vector(5 downto 0) := "000001";
	constant C_B : std_logic_vector(5 downto 0) := "000010";
	constant C_C : std_logic_vector(5 downto 0) := "000011";
	constant C_D : std_logic_vector(5 downto 0) := "000100";
	constant C_E : std_logic_vector(5 downto 0) := "000101";
	constant C_F : std_logic_vector(5 downto 0) := "000110";
	constant C_G : std_logic_vector(5 downto 0) := "000111";
	constant C_H : std_logic_vector(5 downto 0) := "001000";
	constant C_I : std_logic_vector(5 downto 0) := "001001";
	constant C_J : std_logic_vector(5 downto 0) := "001010";
	constant C_K : std_logic_vector(5 downto 0) := "001011";
	constant C_L : std_logic_vector(5 downto 0) := "001100";
	constant C_M : std_logic_vector(5 downto 0) := "001101";
	constant C_N : std_logic_vector(5 downto 0) := "001110";
	constant C_O : std_logic_vector(5 downto 0) := "001111";
	constant C_P : std_logic_vector(5 downto 0) := "010000";
	constant C_Q : std_logic_vector(5 downto 0) := "010001";
	constant C_R : std_logic_vector(5 downto 0) := "010010";
	constant C_S : std_logic_vector(5 downto 0) := "010011";
	constant C_T : std_logic_vector(5 downto 0) := "010100";
	constant C_U : std_logic_vector(5 downto 0) := "010101";
	constant C_V : std_logic_vector(5 downto 0) := "010110";
	constant C_W : std_logic_vector(5 downto 0) := "010111";
	constant C_X : std_logic_vector(5 downto 0) := "011000";
	constant C_Y : std_logic_vector(5 downto 0) := "011001";
	constant C_Z : std_logic_vector(5 downto 0) := "011010";
	constant C_SPACE : std_logic_vector(5 downto 0) := "100000";
	constant C_DASH : std_logic_vector(5 downto 0) := "101101";
	constant C_DOT : std_logic_vector(5 downto 0) := "101110";
	constant C_0 : std_logic_vector(5 downto 0) := "110000";
	constant C_DOWN_ARROW : std_logic_vector(5 downto 0) := "011100";
	constant C_UP_ARROW : std_logic_vector(5 downto 0) := "011110";
END CHARS;