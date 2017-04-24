package cn.util.convert.converters.string;


import cn.util.convert.Converter;

public class ObjectToStringConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		return String.valueOf(from);
	}

}
