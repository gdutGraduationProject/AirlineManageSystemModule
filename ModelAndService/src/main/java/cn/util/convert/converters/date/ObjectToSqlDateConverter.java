package cn.util.convert.converters.date;

import cn.util.convert.Converter;
import cn.util.convert.Converters;

import java.util.Date;

public class ObjectToSqlDateConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		return new java.sql.Date(Converters.BASE
				.convert(from, Date.class, args).getTime());
	}

}
