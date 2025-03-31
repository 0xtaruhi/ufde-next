// Reimplementation of serialcheck.cpp

const TABLE_1: &'static [char; 16] = &['Z', 'Q', 'W', 'R', 'T', 'Y', 'U', 'I', 'P', 'L', 'A', 'B', 'C', 'D', 'E', 'F'];
const TABLE_2: &'static [char; 16] = &['K', 'J', 'H', 'G', 'F', 'D', 'S', 'A', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'L'];
const TABLE_3: &'static [char; 16] = &['G', 'H', 'Y', 'T', 'R', 'F', 'V', 'B', 'N', 'J', 'U', 'I', 'K', 'S', 'X', 'O'];

pub fn check_serial_no_1(serial_no: &str, c_cid: &mut [u8; 4]) -> bool {
    let mut c_serial_no_1 = [0u8; 4];
    let mut c_serial_no_2 = [0u8; 4];
    let mut c_serial_no_3 = [0u8; 4];
    let mut c_serial_no_4 = [0u8; 4];
    let mut c_pid = [0u8; 4];
    let mut c_local_serial_no = [0u8; 21];

    let serial_len = serial_no.len();
    if serial_len != 29 {
        return false;
    }

    c_serial_no_1.copy_from_slice(&serial_no.as_bytes()[0..4]);

    if let Some(pos) = serial_no.find('-') {
        let temp = &serial_no[pos + 1..];
        c_serial_no_2.copy_from_slice(&temp[0..4].as_bytes());

        if let Some(pos) = temp[4..].find('-') {
            let temp2 = &temp[pos + 1..];
            c_serial_no_3.copy_from_slice(&temp2[0..4].as_bytes());

            if let Some(pos) = temp2[4..].find('-') {
                let temp3 = &temp2[pos + 1..];
                c_serial_no_4.copy_from_slice(&temp3[0..4].as_bytes());

                if let Some(pos) = temp3[4..].find('-') {
                    let temp4 = &temp3[pos + 1..];
                    c_cid.copy_from_slice(&temp4[0..4].as_bytes());

                    if let Some(pos) = temp4[4..].find('-') {
                        let temp5 = &temp4[pos + 1..];
                        c_pid.copy_from_slice(&temp5[0..4].as_bytes());

                        // Concatenate the serial number parts
                        let c_local_serial_no_str = format!(
                            "{}{}{}{}",
                            String::from_utf8_lossy(&c_serial_no_1),
                            String::from_utf8_lossy(&c_serial_no_2),
                            String::from_utf8_lossy(&c_serial_no_3),
                            String::from_utf8_lossy(&c_serial_no_4)
                        );

                        println!("{:?}", c_local_serial_no_str);
                        // TODO: return validate_sn(&c_local_serial_no_str);
                        // Causes a segfault! Maybe an implementation error?

                        return true;
                    }
                }
            }
        }
    }

    false
}

pub fn convert_to_word(og_char: &[u8]) -> u16 {
    let temp = og_char;
    let mut w_ret: u16;
    w_ret = 0x0000;
    
    // for char in og_char.chars() {
        
    // }
    for i in 0..3 {
        if i > 0 {
            w_ret <<= 4;
        }

        if temp[ i ] >= b'A' && temp[ i ] <= b'F' {
			w_ret += (temp[i] - b'A' + 10) as u16;
		} else if temp[ i ] >= b'a' && temp[ i ] <= b'f' {
			w_ret += (temp[ i ] - b'a' + 10) as u16;
		} else if temp[ i ] >= b'0' && temp[ i ] <= b'9' {
			w_ret += (temp[ i ] - b'0') as u16;
		} else {
			return 0;
		}
    }

    return w_ret;
}


pub fn validate_sn(c_serial_no: &str) -> bool {
    // Check software version
    if !check_software_version(c_serial_no) {
        return false;
    }

    // Check product
    if !check_product(c_serial_no) {
        return false;
    }

    // Check year
    if !check_year(c_serial_no) {
        return false;
    }

    // Check month
    if !check_month(c_serial_no) {
        return false;
    }

    // Check serial number
    if !check_serial_no(c_serial_no) {
        return false;
    }

    // Check encryption
    if !check_encrypt(c_serial_no) {
        return false;
    }

    true
}

fn check_software_version(c_serial_no: &str) -> bool {
    let valid_digits = |ch: char| ch.is_digit(10);
    
    valid_digits(c_serial_no.chars().nth(1).unwrap()) &&
    valid_digits(c_serial_no.chars().nth(5).unwrap()) &&
    valid_digits(c_serial_no.chars().nth(9).unwrap()) &&
    valid_digits(c_serial_no.chars().nth(11).unwrap())
}

fn check_product(c_serial_no: &str) -> bool {
    let product = match c_serial_no.chars().nth(0).unwrap() {
        'C' => "VeriLite PCI C3",
        'D' => "VeriLite PCI C6",
        'M' => "VeriLite PCI(For update)",
        'U' => "VeriLite USB C12",
        'Q' => "VeriLite USB(For update)",
        'P' => "VeriLite Xilinx USB XC3S250E",
        'R' => "VeriLite Xilinx USB XC3S500E",
        'S' => "VeriEnterprise S80",
        'T' => "VeriEnterprise Altera S60",
        'V' => "VeriEnterprise Xilinx VIRTEX-4 XC4VLX60",
        'W' => "VeriEnterprise Xilinx VIRTEX-4 XC4VLX160",
        'Z' => "VeriEnterprise(For update)",
        'A' => "VeriEnterprise Xilinx XC5VLX110",
        'B' => "VeriEnterprise Xilinx XC5VLX330",
        'E' => "VeriEnterprise Xilinx XC5VLX330-Dual",
        'F' => "VeriLite Xilinx Fudan FDP3P7",
        _ => return false,
    };
    println!("Product: {}", product);
    true
}

fn check_year(c_serial_no: &str) -> bool {
    let c_now_char = c_serial_no.chars().nth(12).unwrap();
    c_now_char.is_alphanumeric()
}

fn check_month(c_serial_no: &str) -> bool {
    let c_now_char = c_serial_no.chars().nth(15).unwrap();
    c_now_char.is_digit(10) || ('A'..='C').contains(&c_now_char)
}

fn check_serial_no(c_serial_no: &str) -> bool {
    let check_char = |index: usize| {
        let c_now_char = c_serial_no.chars().nth(index).unwrap();
        c_now_char.is_alphanumeric()
    };

    check_char(14) && check_char(7) && check_char(3)
}

fn check_encrypt(c_serial_no: &str) -> bool {
    let hex_value = [
        // get_table(c_serial_no.chars().nth(2).unwrap(), TABLE_1),
        // get_table(c_serial_no.chars().nth(4).unwrap(), TABLE_2),
        // get_table(c_serial_no.chars().nth(6).unwrap(), TABLE_3),
        // get_table(c_serial_no.chars().nth(8).unwrap(), TABLE_3),
        // get_table(c_serial_no.chars().nth(10).unwrap(), TABLE_2),
        // get_table(c_serial_no.chars().nth(13).unwrap(), TABLE_1),
        get_table(c_serial_no.chars().nth(2).unwrap(), &TABLE_1.iter().collect::<String>()),
        get_table(c_serial_no.chars().nth(4).unwrap(), &TABLE_2.iter().collect::<String>()),
        get_table(c_serial_no.chars().nth(6).unwrap(), &TABLE_3.iter().collect::<String>()),
        get_table(c_serial_no.chars().nth(8).unwrap(), &TABLE_3.iter().collect::<String>()),
        get_table(c_serial_no.chars().nth(10).unwrap(), &TABLE_2.iter().collect::<String>()),
        get_table(c_serial_no.chars().nth(13).unwrap(), &TABLE_1.iter().collect::<String>()),
    ];

    if hex_value.contains(&'!') {
        return false;
    }

    let c_trans: String = hex_value.iter().collect();
    let c_int_value_r = hex_to_int(&c_trans);
    let c_int_value = [
        (c_int_value_r >> 48) as u8,
        (c_int_value_r >> 40) as u8,
        (c_int_value_r >> 32) as u8,
        (c_int_value_r >> 24) as u8,
        (c_int_value_r >> 16) as u8,
        (c_int_value_r >> 8) as u8,
        (c_int_value_r) as u8
    ];

    let i_value = get_int_value(c_serial_no.chars().nth(14).unwrap()) +
                  get_int_value(c_serial_no.chars().nth(7).unwrap()) * 36 +
                  get_int_value(c_serial_no.chars().nth(3).unwrap()) * 36 * 36 +
                  get_int_value(c_serial_no.chars().nth(15).unwrap()) * 36 * 36 * 36 +
                  get_int_value(c_serial_no.chars().nth(12).unwrap()) * 36 * 36 * 36 * 12;
    
    let binding = (format!("{:07}", i_value)).clone();
    let c_value = binding.as_bytes();
    c_int_value == c_value
}

fn get_table(c_value: char, table: &str) -> char {
    if let Some(i) = table.chars().position(|ch| ch == c_value) {
        int_to_char(i)
    } else {
        '!'
    }
}

fn int_to_char(i_value: usize) -> char {
    if i_value <= 9 {
        std::char::from_digit(i_value as u32, 10).unwrap()
    } else if i_value <= 36 {
        std::char::from_u32(i_value as u32 + 'A' as u32 - 10).unwrap()
    } else {
        '0'
    }
}

fn get_int_value(c_value: char) -> usize {
    if c_value.is_digit(10) {
        c_value.to_digit(10).unwrap() as usize
    } else {
        (c_value as u8 - b'A' + 10) as usize
    }
}

fn hex_to_int(c_hex_str: &str) -> i64 {
    i64::from_str_radix(c_hex_str, 16).unwrap_or(-1)
}