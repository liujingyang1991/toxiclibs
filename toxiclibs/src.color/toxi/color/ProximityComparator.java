/*
 * Some classes in this package have been partly inspired by & bits ported from
 * Python code written by Tom De Smedt & Frederik De Bleser for the "colors" library
 * of Nodebox.net.
 * 
 * http://nodebox.net/code/index.php/Colors
 * 
 * Copyright (c) 2006-2008 Karsten Schmidt <info at postspectacular.com>
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
package toxi.color;

import java.util.Comparator;

/**
 * Compares two colors by their distance to the given target color.
 * 
 * @author toxi
 * 
 */
public class ProximityComparator implements Comparator<ReadonlyTColor> {

	protected ReadonlyTColor col;
	protected DistanceProxy proxy;

	public ProximityComparator(ReadonlyTColor col, DistanceProxy proxy) {
		this.col = col;
		this.proxy = proxy;
	}

	public int compare(ReadonlyTColor a, ReadonlyTColor b) {
		float da = proxy.distanceBetween(col, a);
		float db = proxy.distanceBetween(col, b);
		return da < db ? -1 : da > db ? 1 : 0;
	}

}
