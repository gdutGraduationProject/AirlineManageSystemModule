package cn.util.convert.converters.date;

import cn.util.convert.Converter;
import cn.util.convert.Converters;

import java.sql.Timestamp;
import java.util.Date;

public class ObjectToTimestampConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		return new Timestamp(Converters.BASE.convert(from, Date.class, args)
				.getTime());
	}

}
