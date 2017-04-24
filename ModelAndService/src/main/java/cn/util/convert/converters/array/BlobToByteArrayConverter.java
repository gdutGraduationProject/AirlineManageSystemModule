package cn.util.convert.converters.array;

import org.apache.commons.io.IOUtils;
import cn.util.Lang;
import cn.util.convert.Converter;


import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;

public class BlobToByteArrayConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		Blob blob = (Blob) from;
		try {
			return IOUtils.toByteArray(blob.getBinaryStream());
		} catch (IOException e) {
			throw Lang.unchecked(e);
		} catch (SQLException e) {
			throw Lang.unchecked(e);
		}
	}

}
