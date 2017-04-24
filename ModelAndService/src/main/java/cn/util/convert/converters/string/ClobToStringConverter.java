package cn.util.convert.converters.string;

import org.apache.commons.io.IOUtils;
import cn.util.Lang;
import cn.util.convert.Converter;


import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;

public class ClobToStringConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		Clob clob = (Clob) from;
		try {
			return IOUtils.toString(clob.getCharacterStream());
		} catch (IOException e) {
			throw Lang.unchecked(e);
		} catch (SQLException e) {
			throw Lang.unchecked(e);
		}
	}

}
