package cn.util.convert.converters.primitive;

import cn.util.Lang;
import cn.util.convert.Converter;
import cn.util.convert.Converters;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;

public class ObjectToDoubleConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		String string = Converters.BASE.convert(from, String.class);
		if (args != null && args.length != 0 && args[0] != null) {
			NumberFormat format;
			if (args[0] instanceof NumberFormat) {
				format = (NumberFormat) args[0];
			} else {
				format = new DecimalFormat(args[0].toString());
			}
			try {
				return ((Number) format.parseObject(string)).doubleValue();
			} catch (ParseException e) {
				throw Lang.unchecked(e);
			}
		}
		return Double.valueOf(string);
	}

}
