package cn.util.convert.converters.primitive;

import cn.util.convert.Converter;
import cn.util.lang.Classes;


public class ObjectToClassConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		return Classes.forName(from.toString());
	}

}
